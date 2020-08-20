//
//  ArticleViewModel.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

import RxRelay

enum ArticleEvent {
    case back
}

class ArticleViewModel: BaseViewModel<ArticleEvent> {

    // MARK: - Properties
    
    public let article: ArticleModel
    public let isFavorite = BehaviorRelay<Bool?>(value: nil)
    
    // MARK: - Init and Deinit
    
    init(article: ArticleModel, eventHandler: @escaping Handler<ArticleEvent>) {
        self.article = article
        self.isFavorite.accept(false)
        
        super.init(networking: nil, eventHandler: eventHandler)
    }
    
    // MARK: - Public
    
    public func onAdd() {
        //  save article to storage
        self.isFavorite.accept(true)
    }
    
    public func onRemove() {
        //  remove article from storage
        self.isFavorite.accept(false)
    }

    // MARK: - Private
}

