//
//  BaseViewModel.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

class BaseViewModel<Event>: NSObject {
    
    // MARK: - Properties

    public let eventHandler: Handler<Event>
    
    // MARK: - Init and Deinit
    
    init(serviceContainer: ServiceContainer? = nil, eventHandler: @escaping Handler<Event>) {
        self.eventHandler = eventHandler
        
        super.init()
    }

    deinit {
        debugPrint("deinit: \(String(describing: type(of: self)))")
    }
}

