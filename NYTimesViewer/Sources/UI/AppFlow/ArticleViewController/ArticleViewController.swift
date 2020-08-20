//
//  ArticleViewController.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class ArticleViewController: BaseViewController<ArticleView, ArticleViewModel> {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.navigationItem = self.navigationItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            self.viewModel.eventHandler(.back)
            self.rootView?.webView?.stopLoading()
        }
    }
}
