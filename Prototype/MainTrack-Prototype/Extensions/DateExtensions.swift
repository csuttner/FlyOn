//
//  DateExtensions.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/9/21.
//

import Foundation

extension Date {
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
