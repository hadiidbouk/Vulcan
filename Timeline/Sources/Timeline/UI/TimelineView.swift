import ComposableArchitecture
import Shared
import SwiftUI

private enum Layout {
	static let axisHeight: CGFloat = 30
}

public struct TimelineView: View {
	private let store: Store<TimelineState, TimelineAction>

	public init(store: Store<TimelineState, TimelineAction>) {
		self.store = store
	}

	public var body: some View {
		WithViewStore(store) { viewStore in
			ScrollView([.vertical, .horizontal]) {
				LazyVStack(spacing: .zero) {
					TimelineAxisView(width: viewStore.mainFrame.width)
						.frame(width: viewStore.mainFrame.width, height: Layout.axisHeight)
					ForEachStore(
						store.scope(
							state: \.rows,
							action: TimelineAction.row(id:action:)
						)
					) { store in
						TimelineRowView(
							store: store,
							minWidth: viewStore.mainFrame.width,
							height: viewStore.timelineRect.height / CGFloat(viewStore.rows.count)
						)
					}
					Spacer()
				}
			}
			.rectReader(viewStore.binding(\.$timelineRect))
			.onAppear {
				viewStore.send(.onAppear)
			}
		}
	}
}
