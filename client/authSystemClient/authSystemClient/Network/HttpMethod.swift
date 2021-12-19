//
//  HttpMethod.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import Foundation

enum HttpMethod: String, CustomStringConvertible {
    case get
    case post
    case put
    case delete
    
    var description: String {
        rawValue
    }
}
