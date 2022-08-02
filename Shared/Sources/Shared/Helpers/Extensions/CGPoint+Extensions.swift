//
//  CGPoint+Extensions.swift
//  
//
//  Created by Hadi Dbouk on 31/07/2022.
//

import Foundation

extension CGPoint: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine("\(self.x)-\(self.y)")
	}
}
