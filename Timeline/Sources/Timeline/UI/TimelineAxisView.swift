//
//  TimelineAxisView.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import SwiftUI

private enum Layout {
	static let axisWidth: CGFloat = 50
	static let axesHeight: CGFloat = 10
	static let axesContainerHeight: CGFloat = 30
	static let axesStrokeLineWidth: CGFloat = 0.3
}

struct TimelineAxisView: View {
	let width: CGFloat

	var body: some View {
		VStack {
				let count = Int(width) / Int(Layout.axisWidth)
				HStack(spacing: .zero) {
					ForEach(0..<count, id: \.self) { index in
						path(isLastIndex: index == count - 1)
					}
				}
				.frame(
					minWidth: .zero,
					maxWidth: .infinity,
					minHeight: Layout.axesHeight,
					maxHeight: Layout.axesHeight
				)
			}
			.frame(
				maxWidth: .infinity,
				minHeight: Layout.axesContainerHeight,
				maxHeight: Layout.axesContainerHeight
			)
			.contentShape(Rectangle())
	}
	
	func path(isLastIndex: Bool) -> some View {
		Path { path in
			// Start
			path.move(to: .init(x: 0, y: 0))
			path.addLine(to: .init(x: .zero, y: 12))
			
			// lines
			for x in stride(from: 5, through: 20, by: 5) {
				path.move(to: .init(x: x, y: 0))
				path.addLine(to: .init(x: x, y: 3))
			}
			
			// center
			path.move(to: .init(x: 25, y: 0))
			path.addLine(to: .init(x: 25, y: 8))
			
			// lines
			for x in stride(from: 30, through: 45, by: 5) {
				path.move(to: .init(x: x, y: 0))
				path.addLine(to: .init(x: x, y: 3))
			}
			
			// end
			if isLastIndex {
				path.move(to: .init(x: 50, y: 0))
				path.addLine(to: .init(x: 50, y: 12))
			}
			
			// horizontal line
			path.move(to: .init(x: 0, y: 0))
			path.addLine(to: .init(x: 50, y: 0))
		}
		.stroke(Color.white, lineWidth: Layout.axesStrokeLineWidth)
	}
}
