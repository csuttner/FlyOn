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
    let creatorEmail: String
    let createdDate: String
    var resolvedDate: String?
    var isResolved: Bool
    var defectDescription: String
    var resolutionDescription: String?
    var ac: String
    var sta: String
    var ata4: String
    
    var creatorName: String {
        if let atIndex = creatorEmail.firstIndex(of: "@") {
            return String(creatorEmail.prefix(upTo: atIndex))
        }
        
        return ""
    }
    
    init(_ sta: String, _ ac: String, _ ata4: String, _ defectDescription: String) {
        self.id = UUID.shortString()
        self.creatorEmail = userData!.email
        self.createdDate = Date().getString()
        self.resolvedDate = nil
        self.isResolved = false
        self.defectDescription = defectDescription
        self.resolutionDescription = nil
        self.ac = ac
        self.sta = sta
        self.ata4 = ata4
    }
    
    func resolve() {
        self.isResolved = true
    }
}
