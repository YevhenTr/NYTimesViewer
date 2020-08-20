//
//  EmailedListView.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import SnapKit

class EmailedListView: BaseView<EmailedListViewModel> {

    // MARK: - Subtypes

    // MARK: - Properties
    
    var tableView: UITableView?
    var tableAdapter: TableAdapter?
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: EmailedListViewModel) {
        super.fill(with: viewModel)
        
        let emptyArticle = ArticleModel(title: "", preview: "", url: "", media: [])
        self.tableAdapter?.sections = [
            Section(cell: ArticleCell.self, models: [emptyArticle, emptyArticle, emptyArticle])
        ]
    }
    
    // MARK: - Private
    
    private func configure() {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        self.tableView = tableView
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
        
        let tableAdapter = TableAdapter(table: tableView, cells: [ArticleCell.self])
        self.tableAdapter = tableAdapter
    }
}
