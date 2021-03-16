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
//        if let date =  {
//            return date
//        }
        
//        else {
//            df.dateFormat = "MM-dd-yyyy"
//            if let date = df.date(from: self) {
//                return date
//            } else {
//                df.dateFormat = "MM-dd"
//                if let date = df.date(from: self) {
//                    return date
//                } else {
//                    df.dateFormat = "yyyy-MM-dd"
//                    return df.date(from: self)!
//                }
//            }
//        }
    }
    
}
