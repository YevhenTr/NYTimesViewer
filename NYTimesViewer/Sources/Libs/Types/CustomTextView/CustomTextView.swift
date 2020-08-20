//
//  CustomTextView.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

// UITextView in 'Label' mode.
// Disabled insets, scrolling
// Enabled trancating words
// Use it when you need top alignment for text (UILabel has only center alignment)

class CustomTextView: UITextView {

    // MARK: - Init and Deinit

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        self.configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.configure()
    }

    // MARK: - Private Methods

    private func configure() {
        self.isSelectable = false
        self.isEditable = false
        self.isUserInteractionEnabled = false
        
        self.isScrollEnabled = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
        self.textContainerInset = UIEdgeInsets.zero
        self.textContainer.lineFragmentPadding = 0
        self.textContainer.lineBreakMode = .byTruncatingTail
    }
}
