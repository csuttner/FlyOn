//
//  DefectModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import Foundation

class DefectSection {
    let title: String
    var defects: [Defect]
    
    init(date: Date, defects: [Defect]) {
        self.title = date.headerStyle()
        self.defects = defects
    }
}

class Defect {
    let id: String
    let defectDate: Date
    let resolvedDate: Date? = nil
    var resolved: Bool
    let description: String
    let ac: String
    let sta: String
    let ata4: String
    
    init(description: String, date: Date, ac: String, sta: String, ata4: String, resolved: Bool) {
        self.id = UUID.shortString()
        self.defectDate = date
        self.resolved = resolved
        self.description = description
        self.ac = ac
        self.sta = sta
        self.ata4 = ata4
    }
    
    func resolve() {
        self.resolved = true
    }
}
