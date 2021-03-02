//
//  AtaModel.swift
//  MainTrack
//
//  Created by Clay Suttner on 2/21/21.
//

import Foundation

struct Subchapter: Equatable {
    let ata4: Int
    let subchapterName: String
    
    static func ==(lhs: Subchapter, rhs: Subchapter) -> Bool {
        return lhs.ata4 == rhs.ata4 && lhs.subchapterName == rhs.subchapterName
    }
}

struct Chapter {
    let ata2: Int
    let chapterName: String
    let subchapters: [Subchapter]
}
