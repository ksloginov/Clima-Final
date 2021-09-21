//
//  NetworkError.swift
//  Clima-StartingKit
//
//  Created by Konstantin Loginov on 19.09.2021.
//

import Foundation

enum NetworkError: Error {
    case failedJson
    case failedRequest
    case failedURL
}
