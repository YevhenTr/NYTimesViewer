//
//  ServiceContainer.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

import Reachability

struct ServiceContainer {
    
    // MARK: - Properties
    
    let reachability: Reachability?
    let networking: Networking
    let articleStorage: ArticleStorageService
    
    // MARK: - Init and Deinit
    
    init() {
        let reachability = Reachability()
        try? reachability?.startNotifier()
        self.reachability = reachability
        
        self.networking = Networking(api: NYTimesAPI())
        self.articleStorage = ArticleStorageService()
    }
}
