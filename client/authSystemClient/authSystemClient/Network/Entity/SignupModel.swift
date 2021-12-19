//
//  SignupModel.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import Foundation

struct SignupModel: Codable {
    let email: String?
    let password: String?
    let name: String?
    let nickname: String?
}
