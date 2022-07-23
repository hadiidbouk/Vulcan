//
//  TimelineRowDropDelegate.swift
//  
//
//  Created by Hadi Dbouk on 15/07/2022.
//

import ComposableArchitecture
import SwiftUI

extension TimelineRowView {
	struct DragView: View {
		var body: some View {
			Color.red
		}
	}

	struct Delegate: DropDelegate {
		let viewStore: ViewStore<TimelineRowState, TimelineRowAction>
		
		func dropExited(info: DropInfo) {
			viewStore.send(.dropEntered(position: nil))
		}
		
		func dropEntered(info: DropInfo) {
			viewStore.send(.dropEntered(position: info.location))
		}
		
		func dropUpdated(info: DropInfo) -> DropProposal? {
			viewStore.send(.dropEntered(position: info.location))
			return nil
		}
		
		func performDrop(info: DropInfo) -> Bool {
			let items = info.itemProviders(for: viewStore.fileypes)
			viewStore.send(.onDrop(items: items))
			return true
		}
	}
}
