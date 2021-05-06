//
//  DefectItem.swift
//  FlyOnFeed
//
//  Created by Clay Suttner on 5/3/21.
//

import Foundation

public struct DefectItem: Equatable {
    public let id: UUID
    public let creatorId: UUID
    public var assigneeIds: [UUID]?
    public let stationId: UUID
    public let aircraftId: UUID
    public let ataCodeId: UUID
    public let createdDate: Date
    public var defectDescription: String
    public var resolvedDate: Date?
    public var resolutionDescription: String?
    
    public init(id: UUID, creatorId: UUID, stationId: UUID, aircraftId: UUID, ataCodeId: UUID, createdDate: Date, defectDescription: String) {
        self.id = id
        self.creatorId = creatorId
        self.stationId = stationId
        self.aircraftId = aircraftId
        self.ataCodeId = ataCodeId
        self.createdDate = createdDate
        self.defectDescription = defectDescription
    }
    
    public static func == (lhs: DefectItem, rhs: DefectItem) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct User {
    public let id: UUID
    public let email: String
    public let password: String
    public let firstName: String
    public let lastName: String
    public let role: Role
    public var imageURL: URL?
    
    public init(id: UUID, email: String, password: String, firstName: String, lastName: String, role: Role) {
        self.id = id
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.role = role
    }
}

public enum Role: String {
    case technician
    case pilot
    case analyst
}

public struct Station {
    public let symbol: String
    public let name: String
    
    public init(symbol: String, name: String) {
        self.symbol = symbol
        self.name = name
    }
}

public struct Aircraft {
    public let tailNumber: String
    public let manufacturer: String?
    public let model: String?
    
    public init(tailNumber: String, manufacturer: String, model: String) {
        self.tailNumber = tailNumber
        self.manufacturer = manufacturer
        self.model = model
    }
}

public struct ATACode {
    public let value: Int
    public let description: String
    public let chapter: ATAChapter
    
    public init(value: Int, description: String, chapter: ATAChapter) {
        self.value = value
        self.description = description
        self.chapter = chapter
    }
}

public struct ATAChapter {
    public let value: Int
    public let description: String
    
    public init(value: Int, description: String) {
        self.value = value
        self.description = description
    }
}
