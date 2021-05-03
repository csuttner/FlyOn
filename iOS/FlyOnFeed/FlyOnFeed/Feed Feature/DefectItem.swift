//
//  DefectItem.swift
//  FlyOnFeed
//
//  Created by Clay Suttner on 5/3/21.
//

import Foundation

struct DefectItem {
    let id: UUID
    let creator: User
    var assignees: [User]?
    let station: Station
    let aircraft: Aircraft
    let ataCode: ATACode
    let createdDate: Date
    var defectDescription: String
    var resolvedDate: Date?
    var resolutionDescription: String?
}

struct User {
    let id: UUID
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let role: Role
    let imageURL: URL
}

enum Role {
    case Technician
    case Pilot
    case Analyst
}

struct Station {
    let symbol: String
    let name: String
}

struct Aircraft {
    let tailNumber: String
    let manufacturer: String
    let model: String
}

struct ATACode {
    let value: Int
    let description: String
    let chapter: ATAChapter
}

struct ATAChapter {
    let value: Int
    let description: String
}
