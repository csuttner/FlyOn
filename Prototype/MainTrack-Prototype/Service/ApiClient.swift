//
//  ApiClient.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import Foundation
import Firebase
import CodableFirebase

class ApiClient {
    
    public static let shared = ApiClient()
    private let db = Firestore.firestore()
    private let decoder = FirebaseDecoder()
    private let encoder = FirebaseEncoder()
    
    private init() {}
    
    // MARK: - Defect Methods
    
    public func getAllDefects(completion: @escaping([Defect]) -> Void) {
        print("fetching all defects from Firebase...")
        db.collection("Defects").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error downloading defect: \(error)")
            } else {
                completion(self.decode(from: snapshot!))
            }
        }
    }
    
    private func decode<T: Codable>(from snapshot: QuerySnapshot) -> [T] {
        var output = [T]()
        for document in snapshot.documents {
            let item = try! decoder.decode(T.self, from: document.data())
            output.append(item)
        }
        return output
    }
    
    public func post(_ defect: Defect) throws {
        print("posting defect to Firebase...\nid: \(defect.id)\nsta: \(defect.sta)\nac: \(defect.ac)\nata: \(defect.ata4)\ndesc: \(defect.description)")
        let data = try FirestoreEncoder().encode(defect)
        db.collection("Defects").document(defect.id).setData(data)
    }
    
    public func put(_ defect: Defect) throws {
        print("updating defect on Firebase...\nid: \(defect.id)\nsta: \(defect.sta)\nac: \(defect.ac)\nata: \(defect.ata4)\ndesc: \(defect.description)")
        let data = try FirestoreEncoder().encode(defect)
        db.collection("Defects").document(defect.id).setData(data)
    }
    
    public func delete(_ defect: Defect) throws {
        
    }
    
    // MARK: - User Methods
    public func post(_ user: User) throws {
        print("adding \(user.email) to user pool")
    }
}
