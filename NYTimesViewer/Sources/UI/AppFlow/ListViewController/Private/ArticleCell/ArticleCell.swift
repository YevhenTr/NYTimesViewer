//
//  ArticleCell.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import Kingfisher

enum EmptyCellEvent {
    
}

final class ArticleCell: BaseCell<ArticleModel, EmptyCellEvent> {

    // MARK: - Properties
    
    @IBOutlet var customBackgroundView: UIView?
    
    @IBOutlet var articleImageView: UIImageView?
    @IBOutlet var articleTitleTextView: CustomTextView?
    @IBOutlet var articleDateLabel: UILabel?
    @IBOutlet var articleAuthorLabel: UILabel?
    @IBOutlet var ArticlePreviewTextView: CustomTextView?
    
    private var downloadTask: Kingfisher.DownloadTask?
    private let placeholder = UIImage(named: "nytimesLogoImage")
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundLayer = self.customBackgroundView?.layer
        backgroundLayer?.cornerRadius = 5
        backgroundLayer?.borderColor = UIColor.lightGray.cgColor
        backgroundLayer?.borderWidth = 1
        
        let imageLayer = self.articleImageView?.layer
        imageLayer?.cornerRadius = 5
        imageLayer?.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.articleImageView?.image = nil
        self.articleTitleTextView?.text = nil
        self.articleDateLabel?.text = nil
        self.articleAuthorLabel?.text = nil
        self.ArticlePreviewTextView?.text = nil
        self.downloadTask?.cancel()
    }
    
    // MARK: - Public

    override func fill(with model: ArticleModel) {
        
        if let imageURL = model.imageURL.flatMap(URL.init(string:)) {
            self.downloadTask = self.articleImageView?.kf
                .setImage(with: imageURL, placeholder: self.placeholder)
        } else {
            self.articleImageView?.image = self.placeholder
        }
        
        self.articleTitleTextView?.text = model.title
        self.articleDateLabel?.text = model.publishedAt
        self.articleAuthorLabel?.text = model.byLine 
        self.ArticlePreviewTextView?.text = model.preview
    }
}
