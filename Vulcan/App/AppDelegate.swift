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
	private lazy var store = Store(
		initialState: .init(),
		reducer: appReducer,
		environment: .init(
			timelineEnvironment: .init()
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
        window.identifier = Windows.main.id
        window.setFrameAutosaveName(Windows.main.id.rawValue)
		window.titlebarAppearsTransparent = true
		window.titlebarView?.setBackgroundColor(NSColor(Color.Vulcan.background))
		window.center()
		window.contentView = NSHostingView(rootView: AppView(store: store))
		window.makeKeyAndOrderFront(self)
		self.window = window
	}
}
