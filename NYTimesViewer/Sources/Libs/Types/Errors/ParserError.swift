//
//  ParserError.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

enum ParserError: Error {

    case missingData
    case invalidData
}

extension ParserError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Could not find data object.", comment: "missingData")
        case .invalidData:
            return NSLocalizedString("Could not parse data object.", comment: "invalidData")
        }
    }
}
