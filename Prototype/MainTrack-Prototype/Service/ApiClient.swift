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
    private let firestore: Firestore
    private lazy var firestoreDefects = firestore.collection("Defects")
    private lazy var firestoreArchive = firestore.collection("Archive")
    private lazy var firestoreUserData = firestore.collection("UserData")
    
    private init() {
        FirebaseApp.configure()
        firestore = Firestore.firestore()
    }
    
    // MARK: - Defect Methods

    public func getAllDefects(completion: @escaping([Defect]) -> Void) {
        print("fetching all defects from Firebase...")
        firestoreDefects.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching defects: \(error)")
            } else {
                completion(self.decodeArray(from: snapshot!))
            }
        }
    }

    public func getDefects(for email: String, completion: @escaping([Defect]) -> Void) {
        print("fetching defects for \(email) from Firebase...")
        firestoreDefects.whereField("creatorEmail", isEqualTo: email).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching defects: \(error)")
            } else {
                completion(self.decodeArray(from: snapshot!))
            }
        }
    }

    private func decodeArray<T: Codable>(from snapshot: QuerySnapshot) -> [T] {
        var output = [T]()
        for document in snapshot.documents {
            let item = try! FirebaseDecoder().decode(T.self, from: document.data())
            output.append(item)
        }
        return output
    }

    public func post(_ defect: Defect) {
        print("posting defect id \(defect.id) to Firebase...")
        let data = try! FirestoreEncoder().encode(defect)
        firestoreDefects.document(defect.id).setData(data)
    }

    public func put(_ defect: Defect) {
        print("updating defect id \(defect.id) on Firebase...")
        let data = try! FirestoreEncoder().encode(defect)
        firestoreDefects.document(defect.id).setData(data)
    }

    public func delete(_ defect: Defect) {
        print("deleting defect id \(defect.id) on Firebase...")
        firestoreDefects.document(defect.id).delete()
    }

    //MARK: - Archive Methods

    public func archive(_ defect: Defect) {
        print("adding defect id \(defect.id) to archive on Firebase...")
        let data = try! FirestoreEncoder().encode(defect)
        firestoreArchive.document(defect.id).setData(data)
        delete(defect)
    }

    // MARK: - User Methods
    public func post(_ userData: UserData) {
        print("adding \(userData.email) to user pool")
        let data = try! FirestoreEncoder().encode(userData)
        firestoreUserData.document(userData.email).setData(data)
    }

    public func getUserData(from email: String, completion: @escaping(UserData) -> Void) {
        print("fetching user data for \(email) from Firebase...")
        firestoreUserData.document(email).getDocument { (document, error) in
            if let data = document?.data() {
                let userData = try! FirebaseDecoder().decode(UserData.self, from: data)
                print("successfully fetched data for \(email)")
                completion(userData)
            } else {
                print("user \(email) not found")
            }
        }
    }

    public func checkUserExists(with email: String, completion: @escaping(Bool) -> Void) {
        firestoreUserData.document(email).getDocument { (document, error) in
            if let document = document, document.exists {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
