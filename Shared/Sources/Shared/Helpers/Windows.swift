//
//  Windows.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import AppKit

public enum Windows {
	case main
}

public extension Windows {
	var nsWindow: NSWindow {
		switch self {
		case .main:
			return NSApplication.shared.windows.first { $0.identifier == Constants.WindowIds.main }!
		}
	}
	
	var frame: CGRect {
		switch self {
		case .main:
			return NSRectToCGRect(nsWindow.frame)
		}
	}
}
