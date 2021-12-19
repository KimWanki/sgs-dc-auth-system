//
//  JWTModel.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import Foundation

struct JWT: Codable {
    let accessToken: String
    let expiresIn: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn
    }
}
