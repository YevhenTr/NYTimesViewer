//
//  ServiceContainer.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation


struct ServiceContainer {
    
    // MARK: - Properties
    
    let networking: Networking
    let articleStorage: ArticleStorageService
    
    // MARK: - Init and Deinit
    
    init() {
        self.networking = Networking(api: NYTimesAPI())
        self.articleStorage = ArticleStorageService()
    }
}
