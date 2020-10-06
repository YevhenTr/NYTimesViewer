//
//  ListView.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 21.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import SnapKit

class ListView: BaseView<ListViewModel> {

    // MARK: - Subtypes

    // MARK: - Properties

    @IBOutlet var articleTableView: UITableView?
    @IBOutlet var spinnerView: SpinnerView?
    @IBOutlet var noConnectionView: NoConnectionView?
    
    public var tableAdapter: TableAdapter?

    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: ListViewModel) {
        super.fill(with: viewModel)
        
        let isEditing = !viewModel.shouldCheckNetwork  //  when we work with storage table can be editing
        
        self.tableAdapter?.eventHandler = { [weak viewModel] event in
            switch event {
            case .didSelect(let indexPath):
                viewModel?.onSelect(indexPath: indexPath)
            case .didRemove(let indexPath):
                if isEditing {
                    viewModel?.onRemove(indexPath: indexPath)
                }
            default:
                break
            }
        }
        
        viewModel.articles
            .observeOn(MainScheduler.asyncInstance)
            .bind { [weak self] models in
                self?.tableAdapter?.sections = [Section(cell: ArticleCell.self, models: models, isEditing: isEditing)]
            }
            .disposed(by: self)
        
        viewModel.isLoading
            .observeOn(MainScheduler.asyncInstance)
            .bind { [weak self] isLoading in
                self?.spinnerView?.make(hidden: !isLoading)
            }
            .disposed(by: self)
    }
        
    // MARK: - Private
    
    private func configure() {
        self.tableAdapter = TableAdapter(table: self.articleTableView, cells: [ArticleCell.self])
    }
}
