//
//  Date+StringValue.swift
//  FlyOnFeed
//
//  Created by Clay Suttner on 5/3/21.
//

import Foundation

public extension Date {
    var stringValue: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        let stringDate = formatter.string(from: self)
        return stringDate
    }
    
    init(string: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        self = formatter.date(from: string)!
    }
}
