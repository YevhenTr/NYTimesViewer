//
//  ListViewController_.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 21.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

enum ListEvent_ {
    case open(ArticleModel)
}

class ListViewModel_: BaseViewModel<ListEvent_> {

    // MARK: - Properties
    
    public let articles = BehaviorRelay<[ArticleModel]>(value: [])
    
    public var updateAction: ((@escaping Handler<Result<ArticlesResponseModel, Error>>) -> ())?
    
    // MARK: - Init and Deinit
    
    // MARK: - Public
    
    open func updateData() {
        guard let updateAction = self.updateAction else { return }
        
        updateAction() { result in
            switch result {
            case .success(let response):
                self.handle(response.results)
            case .failure(let error):
                self.handle(error)
            }
        }
    }
    
    open func onSelect(indexPath: IndexPath) {
        guard let article = self.articles.value.object(at: indexPath.row) else { return }

        self.eventHandler(.open(article))
    }

    open func handle(_ error: Error) {
        debugPrint(error)
    }
    
    public func handle(_ articles: [ArticleModel]) {
        self.articles.accept(articles)
    }
}

import UIKit

import RxSwift
import RxCocoa

import SnapKit

class ListView_: BaseView<ListViewModel_> {

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

    override public func fill(with viewModel: ListViewModel_) {
        super.fill(with: viewModel)
        
        self.tableAdapter?.eventHandler = { [weak viewModel] event in
            switch event {
            case .didSelect(let indexPath):
                viewModel?.onSelect(indexPath: indexPath)
            default:
                break
            }
        }
        
        viewModel.articles
            .observeOn(MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .bind { [weak self] models in
                self?.tableAdapter?.sections = [Section(cell: ArticleCell.self, models: models)]
            }
            .disposed(by: self)
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

import UIKit

class ListViewController_: BaseViewController<ListView_, ListViewModel_> {

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.updateData()
    }
}
