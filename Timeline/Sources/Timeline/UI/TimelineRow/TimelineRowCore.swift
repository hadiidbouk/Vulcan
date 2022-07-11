//
//  TimelineRowCore.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import ComposableArchitecture
import Shared
import CoreGraphics

public struct TimelineRowState: Equatable, Identifiable {
	public let id: Int
	var fileypes = ["public.file-url"]
}

public enum TimelineRowAction {
	case onDrop(items: [NSItemProvider])
	case dropEntered(Bool)
}

struct TimelineRowEnvironment {
	let windowsFrameHelper: WindowsFrameHelper

	public init(
		windowsFrameHelper: WindowsFrameHelper
	) {
		self.windowsFrameHelper = windowsFrameHelper
	}
}

let timelineRowReducer = Reducer<TimelineRowState, TimelineRowAction, TimelineRowEnvironment> { state, action, environment in
	switch action {
	case let .onDrop(items):
		return .none
	default:
		return .none
	}
}
