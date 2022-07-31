//
//  Date+Extensions.swift
//  
//
//  Created by Hadi Dbouk on 31/07/2022.
//

import Foundation

public extension Date {
	static func formattedDetailedTime(from timeInterval: TimeInterval) -> String {
		let time = Int(timeInterval)
		let ms = Int((timeInterval.truncatingRemainder(dividingBy: 1)) * 1000)
		let seconds = time % 60
		let minutes = (time / 60) % 60
		let hours = (time / 3600)
		
		return String(format: "%0.2d:%0.2d:%0.2d:%0.3d", hours, minutes, seconds, ms)

	}
}
