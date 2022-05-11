//
//  StorageManager.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 26/04/22.
//

import Foundation
import FirebaseStorage



public class StorageManager {
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum StorageManagerError: Error {
        case failedToDownload
        case failedToUPload
    }
    // MARK: - Public
    
    public func uploadImage(imageData: Data, completion: @escaping (Result<Bool, Error>) -> Void) {
        bucket.child("images/avatar.png").putData(imageData, metadata: nil) { metaData, error in
            guard error == nil else {
                print("Failed to upload")
                completion(.failure(StorageManagerError.failedToUPload))
                return
            }
            completion(.success(true))
        }
    }
    
    public func uploadFeeds(model: UserPostModel, completion: @escaping (Result<URL, Error>) -> Void) {
        
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, Error>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageManagerError.failedToDownload))
                return
            }

            completion(.success(url))
        }
    }

    
}

