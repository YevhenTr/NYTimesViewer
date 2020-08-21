//
//  AppCoordinator.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public final class AppCoordinator: BaseCoordinator<AppCoordinator.Event> {

    // MARK: - Subtypes
    
    public enum Event {
        case mostEmailed
        case favorites
    }
    
    private typealias Text = AppTextConstants
    
    // MARK: - Properties
    
    private let serviceContainer: ServiceContainer
    private let networking: Networking
    private let storage: ArticleStorageService
    
    private var tabbarViewController: UITabBarController?  //  root view controller
    
    // MARK: - Init and Deinit
    
    init(serviceContainer: ServiceContainer, eventHandler: @escaping Handler<AppCoordinator.Event>) {
        self.serviceContainer = serviceContainer
        self.networking = serviceContainer.networking
        self.storage = serviceContainer.articleStorage
        
        super.init(eventHandler: eventHandler)
    }
    
    // MARK: - Public
     
    override func rootViewController() -> UIViewController {
        return self.tabbarViewController ?? self.createTabbarViewController()
    }
    
    // MARK: - Private
    
    // MARK: - TabbarView Controller
    
    private func createTabbarViewController() -> UIViewController {
        let controller = UITabBarController()
        
        controller.viewControllers = self.prepareAppControllers()
        self.tabbarViewController = controller
        
        return controller
    }
    
    private func prepareAppControllers() -> [UIViewController] {
        let mostEmailedController = self.createEmailedListViewController()
        let mostSharedController = self.createSharedListViewController()
        let mostViewedController = self.createViewedListViewController()
        let favoritesController = self.createFavoritesListViewController()
        
        return [
            mostEmailedController,
            mostSharedController,
            mostViewedController,
            favoritesController
        ]
    }
    
    // MARK: - EmailedListViewController
    
    private func createEmailedListViewController() -> ListViewController {
        let viewModel = ListViewModel(serviceContainer: self.serviceContainer, eventHandler: self.listEventHandler)
        let controller = ListViewController(viewModel: viewModel)
        let barItem = UITabBarItem(title: Text.emailed, image: UIImage(named: "emailIcon"), tag: 1)

        controller.tabBarItem = barItem
        viewModel.updateAction = self.networking.getMostEmailedArticles
        
        return controller
    }
    
    // MARK: - SharedListViewController

    private func createSharedListViewController() -> ListViewController {
        let viewModel = ListViewModel(serviceContainer: self.serviceContainer, eventHandler: self.listEventHandler)
        let controller = ListViewController(viewModel: viewModel)
        let barItem = UITabBarItem(title: Text.shared, image: UIImage(named: "shareIcon"), tag: 2)

        controller.tabBarItem = barItem
        viewModel.updateAction = self.networking.getMostSharedArticles
        
        return controller
    }
    
    // MARK: - ViewedListViewController
    
    private func createViewedListViewController() -> ListViewController {
        let viewModel = ListViewModel(serviceContainer: self.serviceContainer, eventHandler: self.listEventHandler)
        let controller = ListViewController(viewModel: viewModel)
        let barItem = UITabBarItem(title: Text.viewed, image: UIImage(named: "likeIcon"), tag: 3)

        controller.tabBarItem = barItem
        viewModel.updateAction = self.networking.getMostViewedArticles
        
        return controller
    }
    
    // MARK: - FavoritesListViewController
    
    private func createFavoritesListViewController() -> ListViewController {
        let viewModel = ListViewModel(serviceContainer: self.serviceContainer, eventHandler: self.listEventHandler)
        let controller = ListViewController(viewModel: viewModel)
        let barItem = UITabBarItem(title: Text.favorites, image: UIImage(named: "favoritesIcon"), tag: 4)

        controller.tabBarItem = barItem
        viewModel.shouldCheckNetwork = false
        viewModel.updateAction = self.storage.readAllArticles
        
        return controller
    }
    
    private func listEventHandler(_ event: ListEvent) {
        switch event {
        case .open(let article):
            self.push(controller: self.createArticleViewController(article))
            self.navigationController.isNavigationBarHidden = false
        case .error(let error):
            self.rootViewController().showErrorAlert(error: error)
        }
    }
    
    // MARK: - ArticleViewController
    
    private func createArticleViewController(_ article: ArticleModel) -> ArticleViewController {
        let viewModel = ArticleViewModel(article: article, serviceContainer: self.serviceContainer, eventHandler: self.articleEventHandler)
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
