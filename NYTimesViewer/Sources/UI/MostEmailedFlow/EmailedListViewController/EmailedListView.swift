//
//  EmailedListView.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class EmailedListView: ListView<EmailedListEvent, EmailedListViewModel> {

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
        
//        self.tableAdapter?.eventHandler = { [weak viewModel] event in
//            switch event {
//            case .didSelect(let indexPath):
//                viewModel?.onSelect(indexPath: indexPath)
//            default:
//                break
//            }
//        }
        
        viewModel.articles
            .observeOn(MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .bind { [weak self] models in
                self?.tableAdapter?.sections = [Section(cell: ArticleCell.self, models: models)]
            }
            .disposed(by: self)
    }
        
    override public func configure() {
        super.configure()

    }
}
