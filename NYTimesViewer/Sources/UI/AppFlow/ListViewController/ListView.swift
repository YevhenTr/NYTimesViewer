//
//  ListView.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

// WARNING
// do not use storyboard for setup UI
// all elements should be setup programmatically
// this is a base class, storyboard will be replaced in child class init

class ListView<Event, ViewModel: ListViewModel<Event>>: BaseView<ViewModel> {

    // MARK: - Subtypes

    // MARK: - Properties

    @IBOutlet var articleTableView: UITableView?
    
    public var tableAdapter: TableAdapter?

    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: ViewModel) {
        super.fill(with: viewModel)
        
    }
        
    public func configure() {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        self.articleTableView = tableView
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
        
        let tableAdapter = TableAdapter(table: tableView, cells: [ArticleCell.self])
        self.tableAdapter = tableAdapter
    }
}
