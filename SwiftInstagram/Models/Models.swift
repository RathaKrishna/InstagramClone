//
//  Models.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 06/05/22.
//

import Foundation


public enum UserPostType {
    case photo, video
}

public enum Gender {
    case male, female, other
}

struct User{
    let username: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}
/// Represent the user post
public struct UserPostModel {
    let identifier: String
    let feedType: UserPostType
    let thumbil: URL
    let postURL:  URL // either video or photo url
    let caption: String?
    let likeCount: [PostLike]
    let comment: [PostComment]
    let createdDate: String
    let taggedUsers: [String]
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let comment: String
    let createdDate: Date
    let likes: [CommentLike]
}
