//
//  AtaModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import Foundation

struct Subchapter: Equatable, Codable {
    let ata4: Int
    let subchapter_name: String
    
    static func ==(lhs: Subchapter, rhs: Subchapter) -> Bool {
        return lhs.ata4 == rhs.ata4 && lhs.subchapter_name == rhs.subchapter_name
    }
}

struct Chapter: Codable {
    let ata2: Int
    let chapter_name: String
    let subchapters: [Subchapter]
}
