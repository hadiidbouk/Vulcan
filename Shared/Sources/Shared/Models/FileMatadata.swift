//
//  FileMatadata.swift
//  
//
//  Created by Hadi Dbouk on 31/07/2022.
//

import UniformTypeIdentifiers

public struct FileMetadata: Equatable {
	public let url: URL
	public let type: UTType
	public let duration: TimeInterval
}
