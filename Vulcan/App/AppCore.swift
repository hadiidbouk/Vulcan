//
//  AppCore.swift
//  Vulcan
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import AppKit
import ComposableArchitecture
import Shared
import Timeline

struct AppState: Equatable {
	var timeline = TimelineState()
	
	var mainFrame: CGRect = .zero
}

enum AppAction {
	case timeline(TimelineAction)
}

struct AppEnvironment {
	let timelineEnvironment: TimelineEnvironment
}

let appReducer = Reducer.combine(
	Reducer<AppState, AppAction, AppEnvironment> { state, action, _ in
		switch action {
		case .timeline:
			return .none
		}
	},
	timelineReducer.pullback(state: \.timeline,
							 action: /AppAction.timeline,
							 environment: \.timelineEnvironment)
)
