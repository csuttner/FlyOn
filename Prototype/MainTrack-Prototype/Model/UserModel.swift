//
//  UserModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import Foundation

enum Role: String, Codable {
    case technician
    case analyst
}

struct User: Codable {
    let id: String
    let email: String
    let password: String
    let role: Role
    
    init(_ email: String, _ password: String, _ role: Role) {
        self.id = UUID.shortString()
        self.email = email
        self.password = password
        self.role = role
    }
}
