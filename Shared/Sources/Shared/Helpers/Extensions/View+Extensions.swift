//
//  View+Extensions.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import SwiftUI

public extension View {
	func rectReader(_ binding: Binding<CGRect>, in coordinatorSpace: CoordinateSpace = .global) -> some View {
		self.background(
			GeometryReader { geometry -> Color in
				let rect = geometry.frame(in: coordinatorSpace)
				DispatchQueue.main.async {
					if binding.wrappedValue != rect {
						binding.wrappedValue = rect
					}
				}
				return .clear
			}
		)
	}
}
