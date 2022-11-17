//
//  TimelineRowCore.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import ComposableArchitecture
import CoreGraphics
import OrderedCollections
import Shared
import UniformTypeIdentifiers

public struct TimelineRowState: Equatable, Identifiable {
	public let id: Int
	var fileypes = ["public.file-url"]
	var dragPosition: CGPoint?
	var dropPosition: CGPoint?
	var items: [TimelineRowItem] = []
	var axisUnitTime: TimeInterval = .zero
	var movieEndDuration: TimeInterval = .zero
	var lastItemEndPosition: CGPoint = .zero
}

public enum TimelineRowAction {
	case onDrop(items: [NSItemProvider], position: CGPoint)
	case dragPositionChanged(position: CGPoint?)
	case didExtractUTType(Result<FileMetadata, AppError>)
	case axisScaleDidChange(unitTime: TimeInterval)
	case mediaPositionsChanged
	case movieEndDurationChanged
	case didGenerateRowItem(_ item: TimelineRowItem)
}

struct TimelineRowEnvironment {
	let mainQueue: AnySchedulerOf<DispatchQueue>
	let fileManager: FileManager
	let mediaDisplayManager: MediaDisplayManager
}

let timelineRowReducer = Reducer<TimelineRowState, TimelineRowAction, TimelineRowEnvironment> { state, action, environment in
	switch action {
	case let .onDrop(items, position):
		guard let item = items.first else {
			return .none
		}
		state.dropPosition = position
		return environment.fileManager.extractMetadata(from: item)
			.receive(on: environment.mainQueue)
			.catchToEffect()
			.map(TimelineRowAction.didExtractUTType)
	case let .didExtractUTType(.success(fileMetadata)):
		guard let dropPosition = state.dropPosition else {
			return Effect(value: TimelineRowAction.mediaPositionsChanged)
		}
		let axisUnitTime = state.axisUnitTime
		return Effect.task {
			let frames = try await environment.mediaDisplayManager.extractVideoFrames(from: fileMetadata.url)
			let item = TimelineRowItem(
				position: dropPosition,
				fileMetadata: fileMetadata,
				axisUnitTime: axisUnitTime,
				frames: frames
			)
			return TimelineRowAction.didGenerateRowItem(item)
		}
	case .didGenerateRowItem(let item):
		state.items.append(item)
		return Effect(value: TimelineRowAction.mediaPositionsChanged)
	case let .didExtractUTType(.failure(error)):
		print(error)
		return .none
	case let .dragPositionChanged(position):
		state.dragPosition = position
		return .none
	case let .axisScaleDidChange(unitTime):
		state.axisUnitTime = unitTime
		state.items = state.items.updatedElements {
			$0.updateInfo(for: unitTime)
		}
		return Effect(value: TimelineRowAction.mediaPositionsChanged)
	case .mediaPositionsChanged:
		state.movieEndDuration = state.items.map(\.endTime).max() ?? .zero
		return Effect(value: .movieEndDurationChanged)
	default:
		return .none
	}
}
