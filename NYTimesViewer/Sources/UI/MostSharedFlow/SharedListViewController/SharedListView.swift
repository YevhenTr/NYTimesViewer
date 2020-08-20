//
//  SharedListView.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SharedListView: ListView<SharedListEvent, SharedListViewModel> {

    // MARK: - Subtypes

    // MARK: - Properties

    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: SharedListViewModel) {
        super.fill(with: viewModel)
        
    }
    
    override public func configure() {
        super.configure()

    }
}
