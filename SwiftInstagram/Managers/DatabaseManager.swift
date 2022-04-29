//
//  DatabaseManager.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 26/04/22.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: - Public
    /// Check if username and email available
    ///  - Parameters
    ///     - email: String
    ///     - username: String
    public func validateNewUser(with email: String, username: String, completion: @escaping ((Bool) -> Void)) {
        completion(true)
    }
    
    /// Insert new user data to database
    ///  - Parameters
    ///     - email: String
    ///     - username: String
    ///        -completion: callback for inster new user
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        // [START basic_write]
        self.database.child(email.safeDatabaseKey()).setValue(["username": username]){ error, ref in
            if error == nil {
                //success
                print("databse created")
                completion(true)
                return
            }
            else {
                //failed
                print("failed to create database -------")
                completion(false)
                return
            }
        }
    }
    
    public func getUsername() {
        print("check database ref \(self.database)")
        self.database.getData { error, snapshot in
            print("were aredfasf \(snapshot.childrenCount)")
        }
        self.database.child("ratha-gmail-com").observeSingleEvent(of: .value, with: { snapshot in
           print("were aredfasf \(snapshot)")
        })
    }
    
}
