//
//  WindowsFrameHelper.swift
//  
//
//  Created by Hadi Dbouk on 11/07/2022.
//

import Foundation
	
public final class WindowsFrameHelper: ObservableObject {
	@Published public var mainFrame: CGRect = .zero
	
	public init() {}
}
