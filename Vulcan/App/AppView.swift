//
//  AppView.swift
//  Vulcan
//
//  Created by Hadi Dbouk on 09/07/2022.
//

import MediaLibrary
import Player
import SwiftUI
import Timeline

private enum Layout {
	static let windowDefaultWidth: CGFloat = 1024
	static let windowDefaultHeight: CGFloat = 576
}

struct AppView: View {
    var body: some View {
		VStack {
			HStack {
				MediaLibraryView()
				PlayerView()
			}
			TimelineView()
		}
		.frame(minWidth: Layout.windowDefaultWidth, minHeight: Layout.windowDefaultHeight)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
		AppView()
    }
}
