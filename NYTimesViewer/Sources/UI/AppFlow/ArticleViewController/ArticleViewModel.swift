//
//  ArticleViewModel.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

import Reachability
import RxRelay

enum ArticleEvent {
    case back
}

class ArticleViewModel: BaseViewModel<ArticleEvent> {

    // MARK: - Properties
    
    public let article: ArticleModel
    public let isFavorite = BehaviorRelay<Bool?>(value: nil)
    public let storage: ArticleStorageService
    public let reachability: Reachability?
    
    public var isReachable: Bool {
        return self.reachability?.connection ?? .wifi != .none
    }
    
    // MARK: - Init and Deinit
    
    init(article: ArticleModel, serviceContainer: ServiceContainer, eventHandler: @escaping Handler<ArticleEvent>) {
        self.article = article
        self.storage = serviceContainer.articleStorage
        self.reachability = serviceContainer.reachability
        
        super.init(eventHandler: eventHandler)
        
        self.checkFavorite()
    }
    
    // MARK: - Public
    
    public func onAdd() {
        let isSaved = self.storage.save(object: article)
        self.isFavorite.accept(isSaved)
    }
    
    public func onRemove() {
        let isDeleted = self.storage.deleteObject(id: self.article.id)
        self.isFavorite.accept(!isDeleted)
    }

    // MARK: - Private
    
    private func checkFavorite() {
        let isFavorite = self.storage.isStored(fileID: self.article.id)
        self.isFavorite.accept(isFavorite)
    }
}

