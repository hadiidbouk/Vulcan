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
    var id: NSUserInterfaceItemIdentifier {
        switch self {
        case .main:
            return .init("main_window")
        }
    }

	var nsWindow: NSWindow {
		switch self {
		case .main:
            return NSApplication.shared.windows.first { $0.identifier == id }!
		}
	}
}
