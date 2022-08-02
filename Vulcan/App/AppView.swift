//
//  AppView.swift
//  Vulcan
//
//  Created by Hadi Dbouk on 09/07/2022.
//

import ComposableArchitecture
import MediaLibrary
import Player
import Shared
import SwiftUI
import Timeline

private enum Layout {
	static let windowDefaultWidth: CGFloat = 1024
	static let windowDefaultHeight: CGFloat = 576
}

struct AppView: View {
	let store: Store<AppState, AppAction>

	var body: some View {
		VStack {
			HStack {
				MediaLibraryView()
				PlayerView()
			}
			TimelineView(store: store.scope(state: \.timeline, action: AppAction.timeline))
		}
		.frame(minWidth: Layout.windowDefaultWidth, minHeight: Layout.windowDefaultHeight)
		.background(Color.Vulcan.background)
	}
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View {
		AppView(
			store: .init(
				initialState: .init(),
				reducer: appReducer,
				environment: .init(
					timelineEnvironment: .init(
						mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
						fileManager: .default
					)
				)
			)
		)
	}
}
