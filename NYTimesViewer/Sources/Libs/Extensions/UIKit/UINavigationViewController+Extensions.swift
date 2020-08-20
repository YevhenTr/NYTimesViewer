//
//  UINavigationViewController+Extensions.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func modalPresentation(_ isModal: Bool = true, style: UIModalPresentationStyle = .fullScreen) {
        self.isModalInPresentation = isModal
        self.modalPresentationStyle = style
    }
}
