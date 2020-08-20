//
//  FavoritesListViewModel.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

enum FavoritesListEvent {
    case open(ArticleModel)
}

class FavoritesListViewModel: ListViewModel<FavoritesListEvent> {

    // MARK: - Properties
    
    let storage: ArticleStorageService
    
    // MARK: - Init and Deinit
    
    init(storage: ArticleStorageService, eventHandler: @escaping Handler<FavoritesListEvent>) {
        self.storage = storage
        
        super.init(eventHandler: eventHandler)
    }
    
    // MARK: - Public

    override func updateData() {
        if let articles = self.storage.readAllObjects() {
            self.handle(articles)
        } else {
            self.handle(StorageError.invalidFetch)
        }
    }
    
    override func onSelect(indexPath: IndexPath) {
        guard let article = self.articles.value.object(at: indexPath.row) else { return }

        self.eventHandler(.open(article))
    }
    
    // MARK: - Private
}

