//
//  ArticleStorageService.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

final class ArticleStorageService: BaseStorageService<ArticleModel> {
    
    // MARK: - Public
    
    public func readAllArticles(completion: @escaping Handler<Result<ArticlesResponseModel, Error>>) {
        if let articles = self.readAllObjects() {
            completion(.success(ArticlesResponseModel(results: articles)))
        } else {
            completion(.failure(StorageError.invalidFetch))
        }
    }
}
