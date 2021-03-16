//
//  DefectModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import Foundation

class DefectSection: Codable {
    let title: String
    let date: Date
    var defects: [Defect]
    
    init(date: Date, defects: [Defect]) {
        self.title = date.headerStyle()
        self.date = date
        self.defects = defects
    }
}

class Defect: Codable {
    let id: String
    let defectDate: Date
    var resolvedDate: Date?
    var resolved: Bool
    var description: String
    var ac: String
    var sta: String
    var ata4: String
    
    init(_ sta: String, _ ac: String, _ ata4: String, _ description: String) {
        self.id = UUID.shortString()
        self.defectDate = Date()
        self.resolvedDate = nil
        self.resolved = false
        self.description = description
        self.ac = ac
        self.sta = sta
        self.ata4 = ata4
    }
    
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
