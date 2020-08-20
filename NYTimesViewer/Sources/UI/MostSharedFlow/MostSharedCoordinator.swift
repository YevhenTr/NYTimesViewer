//
//  MostSharedCoordinator.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public final class MostSharedCoordinator: BaseCoordinator<MostSharedCoordinator.Event> {

    // MARK: - Subtypes
    
    public enum Event {

    }
    
    // MARK: - Properties
    
    private let networking: Networking
    private let storage: ArticleStorageService
    
    private var sharedListViewController: UIViewController?  //  root view controller
     
    // MARK: - Init and Deinit
    
    init(serviceContainer: ServiceContainer, eventHandler: @escaping Handler<MostSharedCoordinator.Event>) {
        self.networking = serviceContainer.networking
        self.storage = serviceContainer.articleStorage
        
        super.init(eventHandler: eventHandler)
    }
    
    // MARK: - Public
     
    override func rootViewController() -> UIViewController {
        return self.sharedListViewController ?? self.createSharedListViewController()
    }
    
    // MARK: - Private
    
    // MARK: - SharedListViewController
    
    private func createSharedListViewController() -> SharedListViewController {
        let viewModel = SharedListViewModel(networking: self.networking, eventHandler: self.sharedListEventHandler)
        let controller = SharedListViewController(viewModel: viewModel)
        let barItem = UITabBarItem(title: "Shared", image: UIImage(named: "shareIcon"), tag: 2)

        controller.tabBarItem = barItem

        return controller
    }
    
    private func sharedListEventHandler(_ event: SharedListEvent) {

    }
}
