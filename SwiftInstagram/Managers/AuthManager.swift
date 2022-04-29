//
//  AuthManager.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 26/04/22.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        /// - check if username is available
        /// - check if email is available
        /// - create account to database
        
        DatabaseManager.shared.validateNewUser(with: email, username: username) { valid in
            if valid {
                /**
                 - Create account
                 - Insert account
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard result != nil , error == nil else {
                        print("some error --- \(error?.localizedDescription ?? "")")
                        completion(false)
                        return
                    }
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { result in
                        if result {
                            completion(true)
                            return
                        }
                        else {
                            print("failed to create user at auth")
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                // Either username or email doesn't exist
                print("It didn't go inside at all")
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping ((Bool) -> Void)) {
        
        if let email = email {
             // email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            // username auth
            print(username)
        }
    }
    
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        }
        catch {
            completion(false)
        }
    }
}
