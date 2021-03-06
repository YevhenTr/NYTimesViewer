//
//  StorageError.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 21.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

enum StorageError: Error {
    
    case invalidFetch
    case failedDelete
}

extension StorageError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidFetch:
            return NSLocalizedString("Unable to fetch data from storage.", comment: "invalidFetch")
        case .failedDelete:
                return NSLocalizedString("Unable to delete data from storage.", comment: "invalidFetch")
        }
    }
}
