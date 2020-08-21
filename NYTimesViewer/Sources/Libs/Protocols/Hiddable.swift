//
//  Hiddable.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 21.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

protocol Hiddable {

    func show()
    func hide()
    func make(hidden: Bool)
}

extension Hiddable where Self: UIView {

    func show() {
        self.make(hidden: false)
    }

    func hide() {
        self.make(hidden: true)
    }

    func make(hidden: Bool) {
        guard let superview = self.superview else { return }

        if self.isHidden != hidden {
            self.isHidden = hidden

            if hidden {
                superview.sendSubviewToBack(self)
            } else {
                superview.bringSubviewToFront(self)
            }
        }
    }
}
