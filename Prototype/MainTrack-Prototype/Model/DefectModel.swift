//
//  DefectModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import Foundation
import FirebaseAuth

class DefectSection: Codable {
    let title: String
    let date: String
    var defects: [Defect]
    
    init(date: Date, defects: [Defect]) {
        self.title = date.headerStyle()
        self.date = date.getString()
        self.defects = defects
    }
}

class Defect: Codable {
    let id: String
    let email: String
    let defectDate: String
    var resolvedDate: String?
    var resolved: Bool
    var description: String
    var ac: String
    var sta: String
    var ata4: String
    
    init(_ sta: String, _ ac: String, _ ata4: String, _ description: String) {
        self.id = UUID.shortString()
        self.email = userData!.email
        self.defectDate = Date().getString()
        self.resolvedDate = nil
        self.resolved = false
        self.description = description
        self.ac = ac
        self.sta = sta
        self.ata4 = ata4
    }
    
    func resolve() {
        self.resolved = true
    }
    
    
}
