//
//  UserModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import Foundation

struct User: Codable {
    let id: UUID
    let email: String
    let firstName: String
    let lastName: String
    let password: String
    
    init(_ email: String, _ firstName: String, _ lastName: String, _ password: String) {
        self.id = UUID()
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
    }
}
