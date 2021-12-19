//
//  ErrorResponse.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import Foundation

struct ErrorResponse: Decodable, LocalizedError {
    let reason: String
    var errorDescription: String? { return reason }
}
