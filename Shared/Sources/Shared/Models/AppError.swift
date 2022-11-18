//
//  AppError.swift
//  
//
//  Created by Hadi Dbouk on 31/07/2022.
//

import Foundation

public enum AppError: LocalizedError {
	case unkownFileType
	case cannotExtractURL
	case cannotExtractUTType
	case cannotGenerateVideoFrame(Error?)
}

extension AppError: Equatable {
	public static func == (lhs: AppError, rhs: AppError) -> Bool {
		switch (lhs, rhs) {
		case (.unkownFileType, .unkownFileType):
			return true
		case (.cannotExtractURL, .cannotExtractURL):
			return true
		case (.cannotExtractUTType, .cannotExtractUTType):
			return true
		case (.cannotGenerateVideoFrame, .cannotGenerateVideoFrame):
			return true
		default:
			return false
		}
	}
}
