//
//  TimelineCore.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import ComposableArchitecture
import Shared

private enum Constants {
	static let mainFrameThrottleTime: TimeInterval = 0.5
}

public struct TimelineState: Equatable {
	var rows: IdentifiedArrayOf<TimelineRowState> = []
	var defaultRowsCount = 5
	var mainFrame: CGRect = .zero
	
	@BindableState var timelineRect: CGRect = .zero
	
	public init() {
		for index in 0..<defaultRowsCount {
			rows.append(.init(id: index))
		}
	}
}

public enum TimelineAction: BindableAction {
	case row(id: TimelineRowState.ID, action: TimelineRowAction)
	case onAppear
	case mainWindowFrameChanged(Result<CGRect, Never>)
	case binding(BindingAction<TimelineState>)
}

public struct TimelineEnvironment {
	let windowsFrameHelper: WindowsFrameHelper
	
	public init(
		windowsFrameHelper: WindowsFrameHelper
	) {
		self.windowsFrameHelper = windowsFrameHelper
	}
}

public let timelineReducer = Reducer.combine(
	Reducer<TimelineState, TimelineAction, TimelineEnvironment> { state, action, environment in
		switch action {
		case .row:
			return .none
		case .onAppear:
			return environment.windowsFrameHelper.$mainFrame
				.throttle(for: .seconds(Constants.mainFrameThrottleTime), scheduler: DispatchQueue.main, latest: true)
				.catchToEffect()
				.map(TimelineAction.mainWindowFrameChanged)
				.eraseToEffect()
		case let .mainWindowFrameChanged(.success(frame)):
			state.mainFrame = frame
			return . none
		default:
			return .none
		}
	}
		.binding()
	,
	timelineRowReducer.forEach(
		state: \.rows,
		action: /TimelineAction.row(id:action:),
		environment: { env in
				.init(
					windowsFrameHelper: env.windowsFrameHelper
				)
		}
	)
)
