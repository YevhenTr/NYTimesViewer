//
//  MostViewedCoordinator.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public final class MostViewedCoordinator: MainCoordinator<MostViewedCoordinator.Event> {

    // MARK: - Subtypes
    
    public enum Event {

    }
    
    // MARK: - Properties
    
    private var viewedListViewController: UIViewController?  //  root view controller
     
    // MARK: - Public
     
    override func rootViewController() -> UIViewController {
        return self.viewedListViewController ?? self.createViewedListViewController()
    }
    
    // MARK: - Private
    
    // MARK: - ViewedListViewController
    
    private func createViewedListViewController() -> ViewedListViewController {
        let viewModel = ViewedListViewModel(networking: self.networking, eventHandler: self.viewedListEventHandler)
        let controller = ViewedListViewController(viewModel: viewModel)
        let barItem = UITabBarItem(title: "Viewed", image: UIImage(named: "likeIcon"), tag: 3)

        controller.tabBarItem = barItem

        return controller
    }
    
    private func viewedListEventHandler(_ event: ViewedListEvent) {
        switch event {
        case .open(let article):
            self.push(controller: self.createArticleViewController(article))
            self.navigationController.isNavigationBarHidden = false
        }
    }
}
