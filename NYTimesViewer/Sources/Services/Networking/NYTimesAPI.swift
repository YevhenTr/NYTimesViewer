//
//  NYTimesAPI.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

struct NYTimesAPI: NetworkAPI {
    
    // MARK: - Subtypes
    
    private enum Constant {
        
        static let apiKey = "4Yxf2lUQrd3Ev5kyJAwE7zNv09cOII89"
        static let scheme = "https"
        static let host = "api.nytimes.com"
        static let path = "/svc/mostpopular/v2/"
    }
    
    // MARK: - Properties
    
    let defaultURLComponents: URLComponents
    let defaultURLQueryItems: [URLQueryItem]
    let defaultHTTPHeader: [String: String]
    
    // MARK: - Init and Deinit
    
    init() {
        var components = URLComponents()
        components.scheme = Constant.scheme
        components.host = Constant.host
        
        self.defaultURLComponents = components
        self.defaultURLQueryItems = [
            URLQueryItem(name: "api-key", value: Constant.apiKey),
        ]
        
        self.defaultHTTPHeader = [
            "Content-Type" : "application/json"
        ]
    }
}
