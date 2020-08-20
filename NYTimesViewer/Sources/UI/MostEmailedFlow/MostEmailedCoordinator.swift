//
//  MostEmailedCoordinator.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public final class MostEmailedCoordinator: MainCoordinator<MostEmailedCoordinator.Event> {

    // MARK: - Subtypes
    
    public enum Event {

    }
    
    // MARK: - Properties
    
    private var emailedListViewController: UIViewController?  //  root view controller
    
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
}
