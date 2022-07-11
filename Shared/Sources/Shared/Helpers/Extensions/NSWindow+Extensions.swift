//
//  NSWindow+Extensions.swift
//  Vulcan
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import AppKit

public extension NSWindow {
	var titlebarContainerView: NSView? {
		contentView?.superview?.subviews.first(where: \.isTitlebarContainerView)
	}

	var titlebarView: NSView? {
		titlebarContainerView?.subviews.first(where: \.isTitlebarView)
	}
}

private extension NSView {
	var isTitlebarContainerView: Bool {
		guard let `class` = NSClassFromString("NSTitlebarContainerView") else {
			return false
		}
		return isKind(of: `class`)
	}

	var isTitlebarView: Bool {
		guard let `class` = NSClassFromString("NSTitlebarView") else {
			return false
		}
		return isKind(of: `class`)
	}
}

private extension NSView {
	func findViews<T: NSView>(subclassOf: T.Type) -> [T] {
		recursiveSubviews.compactMap { $0 as? T }
	}

	var recursiveSubviews: [NSView] {
		subviews + subviews.flatMap(\.recursiveSubviews)
	}
}
