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
	var dragPosition: CGPoint?
}

public enum TimelineRowAction {
	case onDrop(items: [NSItemProvider])
	case dropEntered(position: CGPoint?)
}

struct TimelineRowEnvironment {}

let timelineRowReducer = Reducer<TimelineRowState, TimelineRowAction, TimelineRowEnvironment> { state, action, environment in
	switch action {
	case let .onDrop(items):
		return .none
	case let .dropEntered(position):
		state.dragPosition = position
		return .none
	}
}
