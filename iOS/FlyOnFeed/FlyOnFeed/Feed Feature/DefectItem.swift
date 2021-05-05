//
//  DefectItem.swift
//  FlyOnFeed
//
//  Created by Clay Suttner on 5/3/21.
//

import Foundation

public struct DefectItem: Equatable, Codable {
    public let id: UUID
    public let creator: User
    public var assignees: [User]?
    public let station: Station
    public let aircraft: Aircraft
    public let ataCode: ATACode
    public let createdDate: String
    public var defectDescription: String
    public var resolvedDate: String?
    public var resolutionDescription: String?
    
    public init(id: UUID, creator: User, station: Station, aircraft: Aircraft, ataCode: ATACode, createdDate: String, defectDescription: String) {
        self.id = id
        self.creator = creator
        self.station = station
        self.aircraft = aircraft
        self.ataCode = ataCode
        self.createdDate = createdDate
        self.defectDescription = defectDescription
    }
    
    public static func == (lhs: DefectItem, rhs: DefectItem) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct User: Codable {
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

public enum Role: String, Codable {
    case technician
    case pilot
    case analyst
}

public struct Station: Codable {
    public let symbol: String
    public let name: String
    
    public init(symbol: String, name: String) {
        self.symbol = symbol
        self.name = name
    }
}

public struct Aircraft: Codable {
    public let tailNumber: String
    public let manufacturer: String?
    public let model: String?
    
    public init(tailNumber: String, manufacturer: String, model: String) {
        self.tailNumber = tailNumber
        self.manufacturer = manufacturer
        self.model = model
    }
}

public struct ATACode: Codable {
    public let value: Int
    public let description: String
    public let chapter: ATAChapter
    
    public init(value: Int, description: String, chapter: ATAChapter) {
        self.value = value
        self.description = description
        self.chapter = chapter
    }
}

public struct ATAChapter: Codable {
    public let value: Int
    public let description: String
    
    public init(value: Int, description: String) {
        self.value = value
        self.description = description
    }
}
