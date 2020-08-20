//
//  ListViewModel.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

import RxRelay

class ListViewModel<Event>: BaseViewModel<Event> {

    // MARK: - Properties
    
    public let articles = BehaviorRelay<[ArticleModel]>(value: [])
    
    // MARK: - Init and Deinit
    
    // MARK: - Public
    
    open func updateData() {
        
    }
    
    open func onSelect(indexPath: IndexPath) {

    }

    open func handle(_ error: Error) {
        debugPrint(error)
    }
    
    public func handle(_ response: ArticlesResponseModel) {
        self.articles.accept(response.results)
    }

    // MARK: - Private
}

