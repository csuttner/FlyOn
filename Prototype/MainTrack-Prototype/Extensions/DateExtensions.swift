//
//  DateExtensions.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/9/21.
//

import Foundation

extension Date {
    var timeSymbol: String {
        let interval = DateInterval(start: self, end: Date())
        let duration = interval.duration
        
        let minute: Double = 60
        let hour = minute * 60
        let day = hour * 24
        
        if duration < hour {
            return "\(duration / minute)m"
        } else if duration < day {
            return "\(duration / hour)h"
        } else {
            return "\(duration / day)d"
        }
    }
    
    func headerStyle() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        let dayString = String(formatter.string(from: self).dropLast(6))
        return dayString
    }
    
    func getString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        let stringDate = formatter.string(from: self)
        return stringDate
    }
}
