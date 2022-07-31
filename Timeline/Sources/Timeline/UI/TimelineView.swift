import ComposableArchitecture
import Shared
import SwiftUI

private enum Layout {
	static let axisLeadingPadding: CGFloat = 100
	static let axisTrailingPadding: CGFloat = 20
}

public struct TimelineView: View {
    private let store: Store<TimelineState, TimelineAction>
    
    public init(store: Store<TimelineState, TimelineAction>) {
        self.store = store
    }
    
    public var body: some View {
		WithViewStore(store) { viewStore in
			VStack(spacing: .zero) {
				TimelineToolsView(store: store.scope(state: \.timelineTools, action: TimelineAction.timelineTools))
				ScrollView(.horizontal) {
					VStack(spacing: .zero) {
						TimelineAxisView(store: store.scope(state: \.timelineTools, action: TimelineAction.timelineTools))
							.frame(width: viewStore.timelineRect.width)
							.padding(.leading, Layout.axisLeadingPadding)
							.padding(.trailing, Layout.axisTrailingPadding)
						ScrollView(.vertical) {
							VStack(spacing: .zero) {
								ForEachStore(
									store.scope(
										state: \.rows,
										action: TimelineAction.row(id:action:)
									)
								) { store in
									TimelineRowView(
										store: store,
										height: viewStore.timelineRect.height / CGFloat(viewStore.rows.count)
									)
									.frame(minWidth: viewStore.timelineRect.width, maxWidth: .infinity)
								}
								Spacer()
							}
						}
						.padding(.leading, Layout.axisLeadingPadding)
					}
				}
				.rectReader(viewStore.binding(\.$timelineRect))
			}
		}
	}
}
