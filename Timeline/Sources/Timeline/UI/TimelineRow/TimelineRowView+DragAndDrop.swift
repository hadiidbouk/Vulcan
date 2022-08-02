//
//  TimelineRowDropDelegate.swift
//  
//
//  Created by Hadi Dbouk on 15/07/2022.
//

import ComposableArchitecture
import SwiftUI

private enum Layout {
	static let cornerRadius: CGFloat = 10
	static let strokeBorderLineWidth: CGFloat = 1
	static let strokeDash: [CGFloat] = [5]
}

extension TimelineRowView {
	struct DragView: View {
		var body: some View {
			GeometryReader { gometry in
				RoundedRectangle(cornerRadius: Layout.cornerRadius)
					.strokeBorder(style: .init(lineWidth: Layout.strokeBorderLineWidth, dash: Layout.strokeDash))
					.foregroundColor(Color.Vulcan.white.opacity(0.5))
					.frame(width: gometry.size.width / 2)
			}
		}
	}
	struct Delegate: DropDelegate {
		let viewStore: ViewStore<TimelineRowState, TimelineRowAction>

		func dropExited(info: DropInfo) {
			viewStore.send(.dragPositionChanged(position: nil))
		}

		func dropEntered(info: DropInfo) {
			viewStore.send(.dragPositionChanged(position: info.location))
		}

		func dropUpdated(info: DropInfo) -> DropProposal? {
			viewStore.send(.dragPositionChanged(position: info.location))
			return nil
		}

		func performDrop(info: DropInfo) -> Bool {
			let items = info.itemProviders(for: viewStore.fileypes)
			viewStore.send(.onDrop(items: items, position: info.location))
			return true
		}
	}
}
