//
//  StringExtensions.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/16/21.
//

import Foundation

extension String {
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        return dateFormatter.date(from: self)
    }
    
}
