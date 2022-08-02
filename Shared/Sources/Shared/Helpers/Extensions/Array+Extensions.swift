//
//  Array+Extensions.swift
//  
//
//  Created by Hadi Dbouk on 31/07/2022.
//

import ComposableArchitecture
import Foundation

public extension Array {
	func updatedElements(with action: (inout Element) -> Void) -> [Element] {
		var newElements: [Element] = []
		forEach { element in
			var mutatingElement = element
			action(&mutatingElement)
			newElements.append(mutatingElement)
		}
		return newElements
	}
}

public extension IdentifiedArrayOf where Element: Identifiable {
	func updatedElements(with action: (inout Element) -> Void) -> IdentifiedArrayOf<Element> {
		var newElements: IdentifiedArrayOf<Element> = []
		forEach { element in
			var mutatingElement = element
			action(&mutatingElement)
			newElements.append(mutatingElement)
		}
		return newElements
	}
}
