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
            VStack(spacing: .zero) {
                TimelineAxisView()
                    .frame(width: viewStore.timelineRect.width, height: Layout.axisHeight)
                
                ScrollView([.vertical, .horizontal]) {
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
                .rectReader(viewStore.binding(\.$timelineRect))
            }
		}
	}
}
