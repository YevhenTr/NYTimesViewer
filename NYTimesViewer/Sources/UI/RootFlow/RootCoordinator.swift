//
//  RootCoordinator.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public final class RootCoordinator: BaseCoordinator<RootCoordinator.Event> {

    // MARK: - Subtypes
    
    public enum Event {

    }
    
    // MARK: - Properties
    
    private var emptyViewController: UIViewController?  //  root view controller
     
    private var appCoordinator: AppCoordinator?
    
    // MARK: - Init and Deinit
    
    init() {
        super.init(eventHandler: { _ in })
        
        self.start()
    }
    
    // MARK: - Public
     
    public override func rootViewController() -> UIViewController {
        return self.emptyViewController ?? self.createEmptyViewController()
    }
    
    public func start() {
        self.show(coordinator: self.createAppCoordinator(), animated: false)
    }
    
    // MARK: - Private
    
    private func createEmptyViewController() -> UIViewController {
        let controller = UIViewController()
        
        self.emptyViewController = controller
        
        return controller
    }
    
    // MARK: - AppCoordinator
    
    private func createAppCoordinator() -> AppCoordinator {
        let serviceContainer = ServiceContainer()
        let appCoordinator = AppCoordinator(serviceContainer: serviceContainer, eventHandler: self.appEventHandler)
        
        self.appCoordinator = appCoordinator
        
        return appCoordinator
    }
    
    private func appEventHandler(_ event: AppCoordinator.Event) {
        
    }
}
