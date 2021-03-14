//
//  AtaModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import Foundation

struct Subchapter: Equatable, Codable {
    let ata4: Int
    let subchapterName: String
    
    static func ==(lhs: Subchapter, rhs: Subchapter) -> Bool {
        return lhs.ata4 == rhs.ata4 && lhs.subchapterName == rhs.subchapterName
    }
}

struct Chapter: Codable {
    let ata2: Int
    let chapterName: String
    let subchapters: [Subchapter]
}
