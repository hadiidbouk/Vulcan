//
//  AppDelegate.swift
//  Vulcan
//
//  Created by Hadi Dbouk on 10/07/2022.
//

import ComposableArchitecture
import Shared
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
	private let windowsFrameHelper = WindowsFrameHelper()
	private lazy var store = Store(
		initialState: .init(),
		reducer: appReducer,
		environment: .init(
			timelineEnvironment: .init(windowsFrameHelper: windowsFrameHelper)
		)
	)
	private var window: NSWindow!

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		let window = NSWindow(
			contentRect: .zero,
			styleMask: [.titled, .closable, .miniaturizable, .resizable],
			backing: .buffered,
			defer: false
		)
		window.delegate = self
		window.identifier = Constants.WindowIds.main
		window.setFrameAutosaveName("Vulcan_main_window")
		window.titlebarAppearsTransparent = true
		window.titlebarView?.setBackgroundColor(NSColor(Color.Vulcan.background))
		window.center()
		window.contentView = NSHostingView(rootView: AppView(store: store))
		window.makeKeyAndOrderFront(self)
		self.window = window
	}
}

extension AppDelegate: NSWindowDelegate {
	func windowDidResize(_ notification: Notification) {
		windowsFrameHelper.mainFrame = Windows.main.frame
	}
}
