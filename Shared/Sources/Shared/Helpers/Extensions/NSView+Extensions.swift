//
//  NSView+Extensions.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import AppKit

public extension NSView {
	func setBackgroundColor(_ color: NSColor) {
		setValue(color, forKey: "backgroundColor")
	}
}
