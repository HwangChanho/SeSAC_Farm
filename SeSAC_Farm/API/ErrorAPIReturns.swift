//
//  ErrorAPIReturns.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/03.
//

import Foundation

// MARK: - ErrorAPIReturns
struct ErrorAPIReturns: Codable {
    let statusCode: Int
    let error: String
    // let message: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let id, message: String
}

