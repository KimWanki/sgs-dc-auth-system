//
//  NetworkingError.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import Foundation

enum NetworkingError: Error {
    case InvalidURL
    case InvalidResponse
    case EncodingFail
}
