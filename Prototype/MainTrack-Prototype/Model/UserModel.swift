//
//  UserModel.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import Foundation

var userData: UserData!

enum Role: String, Codable, CaseIterable {
    case technician
    case pilot
}

struct UserData: Codable {
    let email: String
    let password: String
    let role: Role
    
    init(_ email: String, _ password: String, _ role: Role) {
        self.email = email
        self.password = password
        self.role = role
    }
}
