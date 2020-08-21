//
//  ArticleView.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import WebKit
import RxSwift
import RxCocoa

class ArticleView: BaseView<ArticleViewModel> {

    // MARK: - Subtypes

    // MARK: - Properties

    @IBOutlet var spinnerView: SpinnerView?
    @IBOutlet var webView: WKWebView?
    
    public var navigationItem: UINavigationItem?
    private var addItem: UIBarButtonItem?
    private var removeItem: UIBarButtonItem?
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: ArticleViewModel) {
        super.fill(with: viewModel)
                
        if let url = URL(string: viewModel.article.url) {
            self.webView?.load(URLRequest(url: url))
        }
        
        viewModel.isFavorite
            .observeOn(MainScheduler.asyncInstance)
            .bind { [weak self] in
                if let isFavorite = $0 {
                    self?.navigationItem?.rightBarButtonItem = isFavorite ? self?.removeItem : self?.addItem
                } else {
                    self?.navigationItem?.rightBarButtonItem = nil
                }
            }
            .disposed(by: self)
        
        self.addItem?.rx.tap
            .bind { [weak viewModel] in viewModel?.onAdd() }
            .disposed(by: self)

        
        self.removeItem?.rx.tap
            .bind { [weak viewModel] in viewModel?.onRemove() }
            .disposed(by: self)
    }
    
    // MARK: - Private
    
    private func configure() {
        self.webView?.navigationDelegate = self
        
        let addIcon = UIImage(named: "favoritesIcon")
        let removeIcon = UIImage(named: "favoritesFilledIcon")
        self.addItem = UIBarButtonItem(image: addIcon, style: .plain, target: nil, action: nil)
        self.removeItem = UIBarButtonItem(image: removeIcon, style: .plain, target: nil, action: nil)
    }
}

extension ArticleView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.spinnerView?.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinnerView?.hide()
    }
}
