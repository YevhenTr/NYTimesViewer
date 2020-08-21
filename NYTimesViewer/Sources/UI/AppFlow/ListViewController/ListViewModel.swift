//
//  ListViewModel.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 21.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

import Reachability
import RxRelay

enum ListEvent {
    case open(ArticleModel)
    case error(Error)
}

class ListViewModel: BaseViewModel<ListEvent> {

    // MARK: - Properties
    
    public let articles = BehaviorRelay<[ArticleModel]>(value: [])
    public let isLoading = BehaviorRelay<Bool>(value: false)
    public let reachability: Reachability?
    
    public var shouldCheckNetwork = true
    public var updateAction: ((@escaping Handler<Result<ArticlesResponseModel, Error>>) -> ())?
        
    // MARK: - Init and Deinit
    
    init(serviceContainer: ServiceContainer, eventHandler: @escaping Handler<ListEvent>) {
        self.reachability = serviceContainer.reachability
        
        super.init(eventHandler: eventHandler)
    }
    
    // MARK: - Public
    
    public func updateData() {
        guard let updateAction = self.updateAction else { return }
        
        if self.shouldCheckNetwork {
            guard self.reachability?.connection ?? .wifi != .none else { return }
        }
        
        self.isLoading.accept(true)
        
        updateAction() { [weak self] result in
            self?.isLoading.accept(false)
            
            switch result {
            case .success(let response):
                self?.handle(response.results)
            case .failure(let error):
                self?.handle(error)
            }
        }
    }
    
    public func onSelect(indexPath: IndexPath) {
        guard let article = self.articles.value.object(at: indexPath.row) else { return }

        self.eventHandler(.open(article))
    }
    
    // MARK: - Private
    
    private func handle(_ error: Error) {
        self.eventHandler(.error(error))
    }
    
    private func handle(_ articles: [ArticleModel]) {
        self.articles.accept(articles)
    }
}
