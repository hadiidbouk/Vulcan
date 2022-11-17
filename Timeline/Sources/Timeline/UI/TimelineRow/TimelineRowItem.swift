//
//  TimelineRowItem.swift
//  
//
//  Created by Hadi Dbouk on 31/07/2022.
//

import Foundation
import Shared

public struct TimelineRowItem: Identifiable, Equatable {
	public let id = UUID()
	let position: CGPoint
	let fileMetadata: FileMetadata
	let frames: [TimeInterval: [Frame]]

	private(set) var startTime: TimeInterval = .zero
	private(set) var endTime: TimeInterval = .zero
	private(set) var width: CGFloat = .zero

	init(
		position: CGPoint,
		fileMetadata: FileMetadata,
		axisUnitTime: TimeInterval,
		frames: [TimeInterval: [Frame]]
	) {
		self.position = position
		self.fileMetadata = fileMetadata
		self.frames = frames
		updateInfo(for: axisUnitTime)
	}

	mutating func updateInfo(for axisUnitTime: TimeInterval) {
		let info = extractInfo(for: axisUnitTime)
		startTime = info.startTime
		endTime = info.endTime
		width = info.width == .zero ? TimelineConstants.axisUnitWidth : info.width
	}

	private func extractInfo(for axisUnitTime: TimeInterval) -> (width: CGFloat, startTime: TimeInterval, endTime: TimeInterval) {
		let width = (fileMetadata.duration * TimelineConstants.axisUnitWidth) / axisUnitTime
		let startTime = (position.x * axisUnitTime) / TimelineConstants.axisUnitWidth
		let endX = position.x + width
		let endTime = (endX * axisUnitTime) / TimelineConstants.axisUnitWidth

		return (width: width, startTime: startTime, endTime: endTime)
	}
}
