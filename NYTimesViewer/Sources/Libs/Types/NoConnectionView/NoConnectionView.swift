//
//  NoConnectionView.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 21.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class NoConnectionView: NibDesignable, Hiddable {

    // MARK: - Properties
    
    @IBOutlet var titleLabel: UILabel?
    
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
        self.titleLabel?.text = "No Internet Connection"
        self.isHidden = true
    }
}
