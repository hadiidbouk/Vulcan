//
//  TimelineRowView.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import ComposableArchitecture
import SwiftUI

struct TimelineRowView: View {
	let store: Store<TimelineRowState, TimelineRowAction>
	let minWidth: CGFloat
	let height: CGFloat

	var body: some View {
		WithViewStore(store) { viewStore in
			let delegate = Delegate(viewStore: viewStore)
			LazyHStack(spacing: .zero) {
			}
			.frame(minWidth: minWidth, minHeight: height)
			.background(viewStore.id % 2 == 0 ? Color.Vulcan.background : Color.Vulcan.primary.opacity(0.4))
			.onDrop(of: viewStore.fileypes, delegate: delegate)
		}
	}
}

private struct Delegate: DropDelegate {
	let viewStore: ViewStore<TimelineRowState, TimelineRowAction>

	func dropExited(info: DropInfo) {
		viewStore.send(.dropEntered(false))
	}
	
	func dropEntered(info: DropInfo) {
		viewStore.send(.dropEntered(true))
	}
	
	func performDrop(info: DropInfo) -> Bool {
		let items = info.itemProviders(for: viewStore.fileypes)
		viewStore.send(.onDrop(items: items))
		return true
	}
}
