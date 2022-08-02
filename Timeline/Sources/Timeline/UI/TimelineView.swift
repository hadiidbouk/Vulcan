import ComposableArchitecture
import Shared
import SwiftUI

private enum Layout {
	static let rowToolsWidth: CGFloat = 100
	static let axisTrailingPadding: CGFloat = 20
}

public struct TimelineView: View {
	private let store: Store<TimelineState, TimelineAction>

	public init(store: Store<TimelineState, TimelineAction>) {
		self.store = store
	}

	public var body: some View {
		WithViewStore(store) { viewStore in
			VStack(alignment: .leading, spacing: .zero) {
				TimelineToolsView(store: store.scope(state: \.timelineTools, action: TimelineAction.timelineTools))
				ScrollView(.horizontal) {
					HStack {
						Color.Vulcan.accent
							.frame(width: Layout.rowToolsWidth)
						VStack(alignment: .leading, spacing: .zero) {
							TimelineAxisView(store: store.scope(state: \.timelineTools, action: TimelineAction.timelineTools))
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
						}
					}
				}
				.rectReader(viewStore.binding(\.$timelineRect))
			}
		}
	}
}
