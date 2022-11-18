//
//  TimelineToolsCore.swift
//  
//
//  Created by Hadi Dbouk on 30/07/2022.
//

import Foundation
import ComposableArchitecture
import Shared

public struct TimelineToolsState: Equatable {
	@BindableState var scaleValue: Double

	let scaleStep: TimeInterval = 1

	var unitTime: TimeInterval = .zero
	var movieEndDuration: TimeInterval = .zero
	var axisWidth: CGFloat = Windows.main.frame.width

	let scaleRange: ClosedRange<Double>

	init() {
		scaleRange = 0...Double((TimelineConstants.scaleValues.count - 1))
		scaleValue = Double((TimelineConstants.scaleValues.count - 1) / 2)
		unitTime = TimelineConstants.scaleValues[Int(scaleValue)]
	}
}

public enum TimelineToolsAction: BindableAction {
	case binding(BindingAction<TimelineToolsState>)
	case unitTimeChanged
	case movieEndDurationChanged(TimeInterval)
}

struct TimelineToolsEnvironment {
}

let timelineToolsReducer = Reducer<TimelineToolsState, TimelineToolsAction, TimelineToolsEnvironment> { state, action, _ in
	switch action {
	case .binding(\.$scaleValue):
		state.unitTime = TimelineConstants.scaleValues[Int(state.scaleValue)]
		return Effect(value: TimelineToolsAction.unitTimeChanged)
	case .unitTimeChanged:
		return Effect(value: .movieEndDurationChanged(state.movieEndDuration))
	case let .movieEndDurationChanged(duration):
		state.axisWidth = max(Windows.main.frame.width, (duration * TimelineConstants.axisUnitWidth) / state.unitTime)
		state.movieEndDuration = duration
		return .none
	default:
		return .none
	}
}
	.binding()
