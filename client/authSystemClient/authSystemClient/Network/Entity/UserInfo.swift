//
//  JWTModel.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import Foundation

struct UserInfo: Codable {
    let privateInfo: PrivateInfo
    let accessToken: String
    let expiresIn: String
    
    private enum CodingKeys: String, CodingKey {
        case privateInfo
        case accessToken = "access_token"
        case expiresIn
    }
}

struct PrivateInfo: Codable {
    let email: String
    let name: String
    let nickname: String
}
