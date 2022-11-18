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
					TimelineRowView.DragView()
						.frame(height: height)
						.offset(x: position.x)
				}

				ForEach(viewStore.items) { item in
					if let frames = item.frames[viewStore.axisUnitTime] {
						LazyHStack(spacing: .zero) {
							ForEach(frames) { frame in
								frame.image
									.resizable()
									.frame(width: TimelineConstants.axisUnitWidth, height: height)
							}
						}
						.frame(width: item.width)
						.clipped()
						.offset(x: item.position.x)
					}
				}
				Spacer()
			}
			.frame(maxWidth: .infinity, minHeight: height)
			.background(viewStore.id.isMultiple(of: 2) ? Color.Vulcan.background : Color.Vulcan.primary.opacity(0.4))
			.onDrop(of: viewStore.fileypes, delegate: delegate)
		}
	}
}
