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
    
    // MARK: - Properties
    
    private let serviceContainer: ServiceContainer
    let networking: Networking
    let storage: ArticleStorageService
    private var tabbarViewController: UITabBarController?  //  root view controller
     
    private var mostEmailedCoordinator: MostEmailedCoordinator?
    private var mostSharedCoordinator: MostSharedCoordinator?
    private var mostViewedCoordinator: MostViewedCoordinator?
    private var favoritesCoordinator: FavoritesCoordinator?
    
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
//        controller.viewControllers = self.prepareAppCoordinators()
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
    
    private func createEmailedListViewController() -> ListViewController_ {
        let viewModel = ListViewModel_(eventHandler: self.listEventHandler)
        let controller = ListViewController_(viewModel: viewModel)
        let barItem = UITabBarItem(title: "Emailed", image: UIImage(named: "emailIcon"), tag: 1)

        controller.tabBarItem = barItem
        viewModel.updateAction = self.networking.getMostEmailedArticles
        
        return controller
    }
    
    private func createSharedListViewController() -> ListViewController_ {
        let viewModel = ListViewModel_(eventHandler: self.listEventHandler)
        let controller = ListViewController_(viewModel: viewModel)
        let barItem = UITabBarItem(title: "Shared", image: UIImage(named: "shareIcon"), tag: 2)

        controller.tabBarItem = barItem
        viewModel.updateAction = self.networking.getMostSharedArticles
        
        return controller
    }
    
    private func createViewedListViewController() -> ListViewController_ {
        let viewModel = ListViewModel_(eventHandler: self.listEventHandler)
        let controller = ListViewController_(viewModel: viewModel)
        let barItem = UITabBarItem(title: "Viewed", image: UIImage(named: "likeIcon"), tag: 3)

        controller.tabBarItem = barItem
        viewModel.updateAction = self.networking.getMostViewedArticles
        
        return controller
    }
    
    private func createFavoritesListViewController() -> ListViewController_ {
        let viewModel = ListViewModel_(eventHandler: self.listEventHandler)
        let controller = ListViewController_(viewModel: viewModel)
        let barItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favoritesIcon"), tag: 4)

        controller.tabBarItem = barItem
        viewModel.updateAction = self.storage.readAllArticles
        
        return controller
    }
    
    private func listEventHandler(_ event: ListEvent_) {
        switch event {
        case .open(let article):
            self.push(controller: self.createArticleViewController(article))
            self.navigationController.isNavigationBarHidden = false
        }
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
    
    // MARK: - Prepare
    
//    private func prepareAppCoordinators() -> [UIViewController] {
//        let mostEmailedCoordinator = self.createMostEmailedCoordinator()
//        let mostSharedCoordinator = self.createMostSharedCoordinator()
//        let mostViewedCoordinator = self.createMostViewedCoordinator()
//        let favoritesCoordinator = self.createFavoritesCoordinator()
//
//        return [
//            mostEmailedCoordinator.navigationController,
//            mostSharedCoordinator.navigationController,
//            mostViewedCoordinator.navigationController,
//            favoritesCoordinator.navigationController
//        ]
//    }
    
    // MARK: - MostEmailedCoordinator

//    private func createMostEmailedCoordinator() -> MostEmailedCoordinator {
//        let mostEmailedCoordinator = MostEmailedCoordinator(serviceContainer: self.serviceContainer, eventHandler: self.mostEmailedEventHandler)
//
//        self.mostEmailedCoordinator = mostEmailedCoordinator
//
//        return mostEmailedCoordinator
//    }
//
//    private func mostEmailedEventHandler(_ event: MostEmailedCoordinator.Event) {
//
//    }
    
    // MARK: - MostSharedCoordinator

//    private func createMostSharedCoordinator() -> MostSharedCoordinator {
//        let mostSharedCoordinator = MostSharedCoordinator(serviceContainer: self.serviceContainer, eventHandler: self.mostSharedEventHandler)
//
//        self.mostSharedCoordinator = mostSharedCoordinator
//
//        return mostSharedCoordinator
//    }
//
//    private func mostSharedEventHandler(_ event: MostSharedCoordinator.Event) {
//
//    }
    
    // MARK: - MostViewedCoordinator

//    private func createMostViewedCoordinator() -> MostViewedCoordinator {
//        let mostViewedCoordinator = MostViewedCoordinator(serviceContainer: self.serviceContainer, eventHandler: self.mostViewedEventHandler)
//
//        self.mostViewedCoordinator = mostViewedCoordinator
//
//        return mostViewedCoordinator
//    }
//
//    private func mostViewedEventHandler(_ event: MostViewedCoordinator.Event) {
//
//    }
    
    // MARK: - FavoritesCoordinator

//    private func createFavoritesCoordinator() -> FavoritesCoordinator {
//        let favoritesCoordinator = FavoritesCoordinator(serviceContainer: self.serviceContainer, eventHandler: self.favoritesEventHandler)
//
//        self.favoritesCoordinator = favoritesCoordinator
//
//        return favoritesCoordinator
//    }
//
//    private func favoritesEventHandler(_ event: FavoritesCoordinator.Event) {
//
//    }
}
