//
//  TimelineToolsCore.swift
//  
//
//  Created by Hadi Dbouk on 30/07/2022.
//

import ComposableArchitecture
import Shared

public struct TimelineToolsState: Equatable {
	@BindableState var scaleValue: Double

	let scaleStep: TimeInterval = 1
	let scaleAcceptedValues: [TimeInterval] = [
		0.04, 0.1, 0.25, 0.5, 0.75,
		1, 2, 3, 4, 5, 7, 10, 15,
		20, 30, 60, 90, 120, 180,
		240, 300, 420, 600, 900,
		1200, 1800, 3600,
	]

	var unitTime: TimeInterval = .zero
	var movieEndDuration: TimeInterval = .zero
	var axisWidth: CGFloat = Windows.main.frame.width

	let scaleRange: ClosedRange<Double>

	init() {
		scaleRange = 0...Double((scaleAcceptedValues.count - 1))
		scaleValue = Double((scaleAcceptedValues.count - 1) / 2)
		unitTime = scaleAcceptedValues[Int(scaleValue)]
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
		state.unitTime = state.scaleAcceptedValues[Int(state.scaleValue)]
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
