//
//  SharedListViewModel.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

enum SharedListEvent {
    case open(ArticleModel)
}

class SharedListViewModel: ListViewModel<SharedListEvent> {

    // MARK: - Properties
    
    // MARK: - Init and Deinit
    
    // MARK: - Public

    override func updateData() {
        self.networking?.getMostSharedArticles() { [weak self] result in
            switch result {
            case .success(let response):
                self?.handle(response)
            case .failure(let error):
                self?.handle(error)
            }
        }
    }
    
    override func onSelect(indexPath: IndexPath) {
        guard let article = self.articles.value.object(at: indexPath.row) else { return }

        self.eventHandler(.open(article))
    }
    
    // MARK: - Private
}

