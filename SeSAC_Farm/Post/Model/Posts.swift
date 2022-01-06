//
//  Posts.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/05.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let id: Int
    let text: String
    let user: UserClass
    let createdAt, updatedAt: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
