//
//  AppError.swift
//  
//
//  Created by Hadi Dbouk on 31/07/2022.
//

import Foundation

public enum AppError: Equatable, LocalizedError {
	case unkownFileType
	case cannotExtractURL
	case cannotExtractUTType
}
