//
//  SpinnerView.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 21.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class SpinnerView: NibDesignable, Hiddable {

    // MARK: - Properties
    
    @IBOutlet var indicator: UIActivityIndicatorView?
    
    // MARK: - Init and Deinit

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.configure()
    }

    // MARK: - Private

    private func configure() {
        self.backgroundColor = .clear
        self.isHidden = true
    }
}
