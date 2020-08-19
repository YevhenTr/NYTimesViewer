//
//  EmailedListView.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class EmailedListView: BaseView<EmailedListViewModel> {

    // MARK: - Subtypes

    // MARK: - Properties

    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: EmailedListViewModel) {
        super.fill(with: viewModel)
        
    }
    
    // MARK: - Private
    
    private func configure() {
        
    }
}
