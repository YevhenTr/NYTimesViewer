//
//  BaseCoordinator.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public enum CoordinatorPresentationStyle {
    case modal
    case slide
}

public class BaseCoordinator<Event> {
    
    // MARK: - Properties
    
    public let eventHandler: Handler<Event>
    public let presentationStyle: CoordinatorPresentationStyle
    
    public lazy var navigationController: UINavigationController = {
        let navController = UINavigationController(rootViewController: self.rootViewController())
        navController.isNavigationBarHidden = true
        navController.modalPresentation()
        
        return navController
    }()
    
    // MARK: - Init and Deinit
    
    init(eventHandler: @escaping Handler<Event>, presentationStyle: CoordinatorPresentationStyle = .slide) {
        self.eventHandler = eventHandler
        self.presentationStyle = presentationStyle
        
//        self.start()
    }
    
    deinit {
        debugPrint("Coordinator deinit: \(type(of: self))")
    }
    
    // MARK: - Public API
    
    func rootViewController() -> UIViewController {
        fatalError("should be overriden")
    }
    
//    private func start() {
//        self.push(controller: self.rootViewController())
//    }
    
    func show<Event>(coordinator: BaseCoordinator<Event>, animated: Bool = true){
        switch coordinator.presentationStyle {
        case .modal:
            self.navigationController.present(coordinator: coordinator, animated: animated)
        case .slide:
            self.navigationController.push(coordinator: coordinator, animated: animated)
        }
    }
    
    func hide(animated: Bool = true) {
        switch self.presentationStyle {
        case .modal:
            self.navigationController.dismiss(animated: animated)
        case .slide:
            let controller = self.navigationController.parent?.navigationController
            controller?.popViewController(animated: animated)
        }
    }
    
    func push(controller: UIViewController, animated: Bool = true) {
        self.navigationController.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        self.navigationController.popViewController(animated: animated)
    }
}

extension UINavigationController {
    
    fileprivate func push<Event>(coordinator: BaseCoordinator<Event>, animated: Bool = true) {
        let controller = ContainerViewController(with: coordinator.navigationController)
        self.pushViewController(controller, animated: animated)
    }
}

extension UIViewController {
    
    fileprivate func present<Events>(coordinator: BaseCoordinator<Events>,
                         animated: Bool = true,
                         completion: (() -> ())? = nil)
    {
        self.present(coordinator.navigationController, animated: animated, completion: completion)
    }
}
