//
//  TimelineToolsView.swift
//  
//
//  Created by Hadi Dbouk on 30/07/2022.
//

import ComposableArchitecture
import SwiftUI

private enum Layout {
	static let sliderWidth: CGFloat = 150
}

struct TimelineToolsView: View {
	let store: Store<TimelineToolsState, TimelineToolsAction>

	var body: some View {
		WithViewStore(store) { viewStore in
			HStack {
				Slider(
					value: viewStore.binding(\.$scaleValue),
					in: viewStore.scaleRange,
					step: viewStore.scaleStep
				)
				.frame(width: Layout.sliderWidth)

				Text("\(viewStore.unitTime)")

				Spacer()
			}
		}
	}
}
