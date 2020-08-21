//
//  ListViewController.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 21.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import Reachability

class ListViewController: BaseViewController<ListView, ListViewModel> {

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.viewModel.shouldCheckNetwork {
            self.rootView?.noConnectionView?.make(hidden: self.viewModel.reachability?.connection ?? .wifi != .none)
        }
        
        self.viewModel.updateData()
    }
}
