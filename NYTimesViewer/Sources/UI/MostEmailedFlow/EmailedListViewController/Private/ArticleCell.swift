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
    @IBOutlet var ArticlePreviewTextView: CustomTextView?
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundLayer = self.customBackgroundView?.layer
        backgroundLayer?.cornerRadius = 5
        backgroundLayer?.borderColor = UIColor.lightGray.cgColor
        backgroundLayer?.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.articleImageView?.image = nil
        self.articleTitleTextView?.text = nil
        self.ArticlePreviewTextView?.text = nil
    }
    
    // MARK: - Public

    override func fill(with model: ArticleModel) {
        self.articleImageView?.image = nil
        self.articleTitleTextView?.text = model.title
        self.ArticlePreviewTextView?.text = model.preview
    }
}
