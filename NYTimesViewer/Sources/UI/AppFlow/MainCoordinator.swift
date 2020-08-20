//
//  MainCoordinator.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 21.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public class MainCoordinator<Event>: BaseCoordinator<Event> {
    
    // MARK: - Properties
    
    let networking: Networking
    let storage: ArticleStorageService
    
    // MARK: - Init and Deinit
    
    init(serviceContainer: ServiceContainer, eventHandler: @escaping Handler<Event>) {
        self.networking = serviceContainer.networking
        self.storage = serviceContainer.articleStorage
        
        super.init(eventHandler: eventHandler)
    }
    
    // MARK: - ArticleViewController
    
    func createArticleViewController(_ article: ArticleModel) -> ArticleViewController {
        let viewModel = ArticleViewModel(article: article, storage: self.storage, eventHandler: self.articleEventHandler)
        let controller = ArticleViewController(viewModel: viewModel)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController.isNavigationBarHidden = false
        
        return controller
    }
    
    func articleEventHandler(_ event: ArticleEvent) {
        switch event {
        case .back:
            self.navigationController.isNavigationBarHidden = true
        }
    }
}
