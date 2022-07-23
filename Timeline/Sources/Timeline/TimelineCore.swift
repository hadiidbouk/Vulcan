//
//  TimelineCore.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import ComposableArchitecture

public struct TimelineState: Equatable {
	var rows: IdentifiedArrayOf<TimelineRowState> = []
	var defaultRowsCount = 5
	
	@BindableState var timelineRect: CGRect = .zero
	
	public init() {
		for index in 0..<defaultRowsCount {
			rows.append(.init(id: index))
		}
	}
}

public enum TimelineAction: BindableAction {
	case row(id: TimelineRowState.ID, action: TimelineRowAction)
	case binding(BindingAction<TimelineState>)
}

public struct TimelineEnvironment {
    public init() {}
}

public let timelineReducer = Reducer.combine(
	Reducer<TimelineState, TimelineAction, TimelineEnvironment> { state, action, environment in
		switch action {
		case .row:
			return .none
		default:
			return .none
		}
	}
		.binding()
	,
	timelineRowReducer.forEach(
		state: \.rows,
		action: /TimelineAction.row(id:action:),
        environment: { _ in .init() }
	)
)
