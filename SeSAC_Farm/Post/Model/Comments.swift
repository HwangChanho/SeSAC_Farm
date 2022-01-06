//
//  Comments.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/06.
//

import Foundation

// MARK: - Comment
struct Comments: Codable {
    let id: Int
    let comment: String
    let user: UserClass
    let post: Posts?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Post
struct Posts: Codable {
    let id: Int?
    let text: String?
    let user: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
