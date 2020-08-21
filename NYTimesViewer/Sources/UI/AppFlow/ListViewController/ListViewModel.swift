//
//  ListViewModel.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 21.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

import RxRelay

enum ListEvent {
    case open(ArticleModel)
}

class ListViewModel: BaseViewModel<ListEvent> {

    // MARK: - Properties
    
    public let articles = BehaviorRelay<[ArticleModel]>(value: [])
    
    public var updateAction: ((@escaping Handler<Result<ArticlesResponseModel, Error>>) -> ())?
        
    // MARK: - Public
    
    public func updateData() {
        guard let updateAction = self.updateAction else { return }
        
        updateAction() { result in
            switch result {
            case .success(let response):
                self.handle(response.results)
            case .failure(let error):
                self.handle(error)
            }
        }
    }
    
    public func onSelect(indexPath: IndexPath) {
        guard let article = self.articles.value.object(at: indexPath.row) else { return }

        self.eventHandler(.open(article))
    }
    
    // MARK: - Private
    
    private func handle(_ error: Error) {
        debugPrint(error)
    }
    
    private func handle(_ articles: [ArticleModel]) {
        self.articles.accept(articles)
    }
}
