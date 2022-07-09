//
//  AppDelegate.swift
//  Vulcan
//
//  Created by Hadi Dbouk on 10/07/2022.
//

import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
	private var window: NSWindow!

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		let window = NSWindow(
			contentRect: .zero,
			styleMask: [.titled, .closable, .miniaturizable, .resizable],
			backing: .buffered,
			defer: false
		)
		window.setFrameAutosaveName("Vulcan_main_window")
		window.title = "Vulcan"
		window.center()
		window.contentView = NSHostingView(rootView: AppView())
		window.makeKeyAndOrderFront(self)
		self.window = window
	}
}
