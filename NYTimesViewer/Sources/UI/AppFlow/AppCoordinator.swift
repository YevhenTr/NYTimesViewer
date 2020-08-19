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
    
    private var tabbarViewController: UITabBarController?  //  root view controller
     
    private var mostEmailedCoordinator: MostEmailedCoordinator?
    private var mostSharedCoordinator: MostSharedCoordinator?
    private var mostViewedCoordinator: MostViewedCoordinator?
    private var favoritesCoordinator: FavoritesCoordinator?
    
    // MARK: - Init and Deinit
    
    init(eventHandler: @escaping Handler<AppCoordinator.Event>) {
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
        
        controller.viewControllers = self.prepareAppCoordinators()
        self.tabbarViewController = controller
        
        return controller
    }
    
    private func prepareAppCoordinators() -> [UIViewController] {
        let mostEmailedCoordinator = self.createMostEmailedCoordinator()
        let mostSharedCoordinator = self.createMostSharedCoordinator()
        let mostViewedCoordinator = self.createMostViewedCoordinator()
        let favoritesCoordinator = self.createFavoritesCoordinator()

        return [
            mostEmailedCoordinator.navigationController,
            mostSharedCoordinator.navigationController,
            mostViewedCoordinator.navigationController,
            favoritesCoordinator.navigationController
        ]
    }
    
    // MARK: - MostEmailedCoordinator

    private func createMostEmailedCoordinator() -> MostEmailedCoordinator {
        let mostEmailedCoordinator = MostEmailedCoordinator(eventHandler: self.mostEmailedEventHandler)
        
        self.mostEmailedCoordinator = mostEmailedCoordinator
        
        return mostEmailedCoordinator
    }

    private func mostEmailedEventHandler(_ event: MostEmailedCoordinator.Event) {

    }
    
    // MARK: - MostSharedCoordinator

    private func createMostSharedCoordinator() -> MostSharedCoordinator {
        let mostSharedCoordinator = MostSharedCoordinator(eventHandler: self.mostSharedEventHandler)

        self.mostSharedCoordinator = mostSharedCoordinator

        return mostSharedCoordinator
    }

    private func mostSharedEventHandler(_ event: MostSharedCoordinator.Event) {

    }
    
    // MARK: - MostViewedCoordinator

    private func createMostViewedCoordinator() -> MostViewedCoordinator {
        let mostViewedCoordinator = MostViewedCoordinator(eventHandler: self.mostViewedEventHandler)

        self.mostViewedCoordinator = mostViewedCoordinator

        return mostViewedCoordinator
    }

    private func mostViewedEventHandler(_ event: MostViewedCoordinator.Event) {

    }
    
    // MARK: - FavoritesCoordinator

    private func createFavoritesCoordinator() -> FavoritesCoordinator {
        let favoritesCoordinator = FavoritesCoordinator(eventHandler: self.favoritesEventHandler)

        self.favoritesCoordinator = favoritesCoordinator

        return favoritesCoordinator
    }

    private func favoritesEventHandler(_ event: FavoritesCoordinator.Event) {

    }
}
