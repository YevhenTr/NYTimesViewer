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
    
    init(article: ArticleModel, networking: Networking? = nil, eventHandler: @escaping Handler<ArticleEvent>) {
        self.article = article
        self.isFavorite.accept(false)
        
        super.init(networking: networking, eventHandler: eventHandler)
    }
    
    // MARK: - Public

    // MARK: - Private
}

