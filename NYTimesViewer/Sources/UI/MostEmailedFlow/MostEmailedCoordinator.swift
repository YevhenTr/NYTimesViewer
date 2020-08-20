//
//  MostEmailedCoordinator.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public final class MostEmailedCoordinator: BaseCoordinator<MostEmailedCoordinator.Event> {

    // MARK: - Subtypes
    
    public enum Event {

    }
    
    // MARK: - Properties
    
    private let networking: Networking

    private var emailedListViewController: UIViewController?  //  root view controller
     
    
    // MARK: - Init and Deinit
    
    init(serviceContainer: ServiceContainer, eventHandler: @escaping Handler<MostEmailedCoordinator.Event>) {
        self.networking = serviceContainer.networking
        
        super.init(eventHandler: eventHandler)
    }
    
    // MARK: - Public
     
    override func rootViewController() -> UIViewController {
        return self.emailedListViewController ?? self.createEmailedListViewController()
    }
    
    // MARK: - Private
    
    // MARK: - EmailedListViewController
    
    private func createEmailedListViewController() -> EmailedListViewController {
        let viewModel = EmailedListViewModel(networking: self.networking, eventHandler: self.emailedListEventHandler)
        let controller = EmailedListViewController(viewModel: viewModel)
        let barItem = UITabBarItem(title: "Emailed", image: UIImage(named: "emailIcon"), tag: 1)

        controller.tabBarItem = barItem

        return controller
    }
    
    private func emailedListEventHandler(_ event: EmailedListEvent) {
        switch event {
        case .open(let article):
            self.push(controller: self.createArticleViewController(article))
            self.navigationController.isNavigationBarHidden = false
        }
    }
    
    // MARK: - ArticleViewController
    
    private func createArticleViewController(_ article: ArticleModel) -> ArticleViewController {
        let viewModel = ArticleViewModel(article: article, networking: self.networking, eventHandler: self.articleEventHandler)
        let controller = ArticleViewController(viewModel: viewModel)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController.isNavigationBarHidden = false
        
        return controller
    }
    
    private func articleEventHandler(_ event: ArticleEvent) {
        switch event {
        case .back:
            self.navigationController.isNavigationBarHidden = true
        }
    }
}
