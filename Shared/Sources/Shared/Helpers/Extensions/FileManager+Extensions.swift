//
//  FileManager+Extensions.swift
//  
//
//  Created by Hadi Dbouk on 31/07/2022.
//

import AVFoundation
import Combine
import ComposableArchitecture
import UniformTypeIdentifiers

public extension FileManager {
	func extractMetadata(from itemProvider: NSItemProvider) -> Effect<FileMetadata, AppError> {
		Future { promise in
			guard let identifier = itemProvider.registeredTypeIdentifiers.first else {
				promise(.failure(.unkownFileType))
				return
			}

			itemProvider.loadItem(forTypeIdentifier: identifier, options: nil) { urlData, _ in
				guard
					let urlData = urlData as? Data,
					let url = URL(dataRepresentation: urlData, relativeTo: nil)
				else {
					promise(.failure(.cannotExtractURL))
					return
				}
				guard let type = UTType(filenameExtension: url.pathExtension) else {
					promise(.failure(.cannotExtractUTType))
					return
				}

				let asset = AVAsset(url: url)

				let metadata = FileMetadata(
					url: url,
					type: type,
					duration: asset.duration.seconds
				)

				promise(.success(metadata))
			}
		}
		.eraseToEffect()
	}
}
