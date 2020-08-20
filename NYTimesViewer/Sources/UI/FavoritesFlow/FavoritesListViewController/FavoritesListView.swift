//
//  FavoritesListView.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class FavoritesListView: ListView<FavoritesListEvent, FavoritesListViewModel> {

    // MARK: - Subtypes

    // MARK: - Properties

    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: FavoritesListViewModel) {
        super.fill(with: viewModel)
        
    }
    
    override public func configure() {
        super.configure()

    }
}
