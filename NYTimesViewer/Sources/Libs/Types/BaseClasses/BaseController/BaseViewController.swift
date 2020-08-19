//
//  BaseViewController.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class BaseViewController<RootView: BaseView<ViewModel>, ViewModel>: UIViewController {

    // MARK: - Properties
    
    public var rootView: RootView? {
        return self.viewIfLoaded as? RootView
    }

    public let viewModel: ViewModel
    
    // MARK: - Init and Deinit
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rootView?.fill(with: self.viewModel)
    }
}

