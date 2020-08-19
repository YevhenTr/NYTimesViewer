//
//  NetworkError.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

enum NetworkError: Error {

    case invalidURLRequest
    case invalidURL
}

extension NetworkError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidURLRequest:
            return NSLocalizedString("Unable to create URLRequest.", comment: "invalidURLRequest")
        case .invalidURL:
            return NSLocalizedString("Unable to create URL.", comment: "invalidURL")
        }
    }
}
