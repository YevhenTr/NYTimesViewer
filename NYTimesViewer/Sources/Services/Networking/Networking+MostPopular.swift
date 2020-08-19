//
//  Networking+MostPopular.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

fileprivate enum Constant {
    
    static let mostPopularPrefix = "/svc/mostpopular/v2/"
    static let period = "/1.json"  //  1, 7 or 30 days
}

extension Networking {
    
    public func getMostEmailedArticles(completion: @escaping Handler<Result<ArticlesResponseModel, Error>>) {
        let request = self.createRequest(path: Constant.mostPopularPrefix + "emailed" + Constant.period)

        return self.send(request: request, completion: completion)
    }
    
    public func getMostSharedArticles(completion: @escaping Handler<Result<ArticlesResponseModel, Error>>) {
        let request = self.createRequest(path: Constant.mostPopularPrefix + "shared" + Constant.period)

        return self.send(request: request, completion: completion)
    }
    
    public func getMostViewedArticles(completion: @escaping Handler<Result<ArticlesResponseModel, Error>>) {
        let request = self.createRequest(path: Constant.mostPopularPrefix + "viewed" + Constant.period)

        return self.send(request: request, completion: completion)
    }
}
