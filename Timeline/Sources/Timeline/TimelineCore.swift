//
//  TimelineCore.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import ComposableArchitecture
import Shared

public struct TimelineState: Equatable {
    @BindableState var timelineRect: CGRect = .zero
    
    var rows: IdentifiedArrayOf<TimelineRowState> = []
	var defaultRowsCount = 5
	var timelineTools = TimelineToolsState()
	var movieEndDuration: TimeInterval = .zero

	public init() {
		for index in 0..<defaultRowsCount {
			let row = TimelineRowState(id: index, axisUnitTime: timelineTools.unitTime)
			rows.append(row)
		}
	}
}

public enum TimelineAction: BindableAction {
	case timelineTools(TimelineToolsAction)
	case row(id: TimelineRowState.ID, action: TimelineRowAction)
	case binding(BindingAction<TimelineState>)
	case mediaPositionChanged
	case movieEndDurationChanged
}

public struct TimelineEnvironment {
	let mainQueue: AnySchedulerOf<DispatchQueue>
	let fileManager: FileManager

    public init(
		mainQueue: AnySchedulerOf<DispatchQueue>,
		fileManager: FileManager
	) {
		self.mainQueue = mainQueue
		self.fileManager = fileManager
	}
}

public let timelineReducer = Reducer.combine(
	Reducer<TimelineState, TimelineAction, TimelineEnvironment> { state, action, environment in
		switch action {
		case .timelineTools(.unitTimeChanged):
			let unitTime = state.timelineTools.unitTime
			var effects: [Effect<TimelineAction, Never>] = []
			state.rows = state.rows.updatedElements { element in
				let id = element.id
				let effect = timelineRowReducer.run(
					&element,
					.axisScaleDidChange(unitTime: unitTime),
					.init(
						mainQueue: environment.mainQueue,
						fileManager: environment.fileManager
					)
				)
				
				effects.append(effect.map { TimelineAction.row(id: id, action: $0) })
			}
			
			return Effect.merge(effects)
				
		case let .row(id, action: .movieEndDurationChanged):
			let rowState = state.rows[id]
			state.movieEndDuration = max(state.movieEndDuration, rowState.movieEndDuration)
			
			var timelineToolsState = state.timelineTools
			let effect = timelineToolsReducer.run(
				&timelineToolsState,
				.movieEndDurationChanged(state.movieEndDuration),
				.init()
			)
				.map(TimelineAction.timelineTools)
			
			state.timelineTools = timelineToolsState
			return Effect.merge(
				effect,
				Effect(value: TimelineAction.movieEndDurationChanged)
			)
		default:
			return .none
		}
	}
		.binding()
	,
	timelineRowReducer.forEach(
		state: \.rows,
		action: /TimelineAction.row(id:action:),
		environment: { .init(
			mainQueue: $0.mainQueue,
			fileManager: $0.fileManager)
		}
	),
	timelineToolsReducer.pullback(
		state: \.timelineTools,
		action: /TimelineAction.timelineTools,
		environment: { _ in .init() }
	)
)
