//
//  ApiClient.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import Foundation

class ApiClient {
    
    public static let shared = ApiClient()
    
    private init() {}
    
    // MARK: - Defect Methods
    public func post(_ defect: Defect) throws {
        print("posting defect to server...\nid: \(defect.id)\nsta: \(defect.sta)\nac: \(defect.ac)\nata: \(defect.ata4)\ndesc: \(defect.description)")
    }
    
    public func put(_ defect: Defect) throws {
        print("updating defect on server...\nid: \(defect.id)\nsta: \(defect.sta)\nac: \(defect.ac)\nata: \(defect.ata4)\ndesc: \(defect.description)")
    }
    
    // MARK: - User Methods
    public func post(_ user: User) throws {
        print("adding \(user.email) to user pool")
    }
}
