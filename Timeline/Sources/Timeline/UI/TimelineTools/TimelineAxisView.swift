//
//  TimelineAxisView.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import ComposableArchitecture
import Shared
import SwiftUI

private enum Layout {
	static let height: CGFloat = 25
	static let strokeLineWidth: CGFloat = 0.3
	static let fontSize: CGFloat = 10
}

struct TimelineAxisView: View {
	let store: Store<TimelineToolsState, TimelineToolsAction>

	var body: some View {
		WithViewStore(store) { viewStore in
			VStack(alignment: .leading) {
				let count = Int(viewStore.axisWidth) / Int(TimelineConstants.axisUnitWidth)
				HStack(spacing: .zero) {
					LazyHStack(spacing: .zero) {
						ForEach(0..<count, id: \.self) { index in
							VStack(alignment: .leading, spacing: .zero) {
								Text(Date.formattedDetailedTime(from: viewStore.unitTime * Double(index + 1)))
									.font(.system(size: Layout.fontSize))
									.fontWeight(.light)
									.foregroundColor(Color.Vulcan.white)
								AxisShape(isLastAxis: index == count - 1)
									.stroke(Color.Vulcan.white, lineWidth: Layout.strokeLineWidth)
									.frame(width: TimelineConstants.axisUnitWidth)
							}
						}
					}
					Spacer()
				}
			}
			.frame(width: viewStore.axisWidth, height: Layout.height)
		}
	}
}

private struct AxisShape: Shape {
	let isLastAxis: Bool

	func path(in rect: CGRect) -> Path {
		let startYOffset = rect.height / 4
		var path = Path()
		path.move(to: CGPoint(x: rect.minX, y: rect.minY + startYOffset))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

		path.move(to: CGPoint(x: rect.minX + rect.width / 6, y: rect.maxY))
		for x in stride(from: rect.minX + rect.width / 6, to: rect.maxX, by: rect.width / 6) {
			path.move(to: CGPoint(x: x, y: rect.maxY))

			let y = x == rect.midX ? rect.midY : rect.midY + startYOffset
			path.addLine(to: CGPoint(x: x, y: y))
		}
		if isLastAxis {
			path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + startYOffset))
		}

		return path
	}
}
