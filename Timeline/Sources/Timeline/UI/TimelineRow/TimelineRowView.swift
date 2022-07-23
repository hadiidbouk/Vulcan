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
	let height: CGFloat

	var body: some View {
		WithViewStore(store) { viewStore in
			let delegate = Delegate(viewStore: viewStore)
			HStack(spacing: .zero) {
				if let position = viewStore.dragPosition {
					Color.red
						.frame(width: 200, height: height)
						.offset(x: position.x)
				}
				Spacer()
			}
            .frame(maxWidth: .infinity, minHeight: height)
			.background(viewStore.id % 2 == 0 ? Color.Vulcan.background : Color.Vulcan.primary.opacity(0.4))
			.onDrop(of: viewStore.fileypes, delegate: delegate)
		}
	}
}
