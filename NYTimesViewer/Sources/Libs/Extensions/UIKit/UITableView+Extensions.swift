//
//  UITableView+Extensions.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

extension UITableView {
    
    @discardableResult
    public func dequeueReusableCell<Result>(withCellClass cellClass: AnyClass, for indexPath: IndexPath) -> Result
        where Result: UITableViewCell
    {
        let cell = self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
        
        guard let value = cell as? Result else {
            fatalError("Could not find identifier")
        }
        
        return value
    }
    
    public func dequeueReusableCell(withCellClass cellClass: AnyClass, for indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
    }
    
    func register(_ cellClass: AnyClass) {
        let nib = UINib(nibName: toString(cellClass), bundle: nil)
        self.register(nib, forCellReuseIdentifier: toString(cellClass))
    }
}

extension UITableViewCell {
    
    static var nib: UINib {
        return UINib(nibName: self.identifire, bundle: nil)
    }
    
    static var identifire: String {
        return String(describing: self)
    }
}
