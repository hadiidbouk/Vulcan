//
//  MediaDisplayManager.swift
//  
//
//  Created by Hadi Dbouk on 04/08/2022.
//

import AVFoundation
import Cocoa
import Shared
import SwiftUI

struct Frame: Identifiable, Equatable {
	let id = UUID()
	let image: Image
}

public final class MediaDisplayManager {
	public init() {}

	func extractVideoFrames(from url: URL) async throws -> [TimeInterval: [Frame]] {
		let asset = AVAsset(url: url)

		return try await withThrowingTaskGroup(of: (TimeInterval, [Frame]).self) { group in
			for scale in TimelineConstants.scaleValues {
				group.addTask {
					let frames = try await self.extractFrames(from: asset, for: scale)
					return (scale, frames)
				}
			}

			var outputs: [TimeInterval: [Frame]] = [:]
			for try await (scale, frames) in group {
				outputs[scale] = frames
			}
			return outputs
		}
	}
}

private extension MediaDisplayManager {
	func extractFrames(from asset: AVAsset, for scale: TimeInterval) async throws -> [Frame] {
		let duration = asset.duration.seconds

		var times = [NSValue]()
		if scale > duration {
			let cmTime = CMTime(seconds: duration / 2, preferredTimescale: 600)
			times.append(NSValue(time: cmTime))
		} else {
			for time in stride(from: scale, to: duration, by: scale) {
				let firstFrameTime = time / 2
				let cmTime = CMTime(seconds: firstFrameTime, preferredTimescale: 600)
				times.append(NSValue(time: cmTime))
			}
		}

		return try await withCheckedThrowingContinuation { continuation in
			var frames: [Frame] = []

			let imageGenerator = AVAssetImageGenerator(asset: asset)
			imageGenerator.appliesPreferredTrackTransform = true
			imageGenerator.generateCGImagesAsynchronously(forTimes: times) { requestedTime, cgImage, actualTime, _, error in
				guard error == nil else {
					continuation.resume(throwing: AppError.cannotGenerateVideoFrame(error))
					return
				}
				if let cgImage = cgImage {
					let nsImage = NSImage(
						cgImage: cgImage,
						size: CGSize(width: cgImage.width, height: cgImage.height)
					)
					let image = Image(nsImage: nsImage)
					let frame = Frame(image: image)
					frames.append(frame)
					if requestedTime == times.last?.timeValue {
						continuation.resume(returning: frames)
					}
				}
			}
		}
	}
}
