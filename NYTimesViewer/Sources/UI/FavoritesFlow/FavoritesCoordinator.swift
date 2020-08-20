//
//  FavoritesCoordinator.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public final class FavoritesCoordinator: MainCoordinator<FavoritesCoordinator.Event> {

    // MARK: - Subtypes
    
    public enum Event {

    }
    
    // MARK: - Properties
    
    private var favoritesListViewController: UIViewController?  //  root view controller
     
    // MARK: - Public
     
    override func rootViewController() -> UIViewController {
        return self.favoritesListViewController ?? self.createFavoritesListViewController()
    }
    
    // MARK: - Private
    
    // MARK: - FavoritesListViewController

    private func createFavoritesListViewController() -> FavoritesListViewController {
        let viewModel = FavoritesListViewModel(storage: self.storage, eventHandler: self.favoritesListEventHandler)
        let controller = FavoritesListViewController(viewModel: viewModel)
        let barItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favoritesIcon"), tag: 4)

        controller.tabBarItem = barItem

        return controller
    }
    
    private func favoritesListEventHandler(_ event: FavoritesListEvent) {
        switch event {
        case .open(let article):
            self.push(controller: self.createArticleViewController(article))
            self.navigationController.isNavigationBarHidden = false
        }
    }
}
