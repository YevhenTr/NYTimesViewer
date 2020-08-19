//
//  AppDelegate.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?
    
    private var rootCoordinator: RootCoordinator?
    
    // MARK: - Public

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootCoordinator = RootCoordinator()
        window.rootViewController = rootCoordinator.navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        self.rootCoordinator = rootCoordinator
        
        return true
    }
}

