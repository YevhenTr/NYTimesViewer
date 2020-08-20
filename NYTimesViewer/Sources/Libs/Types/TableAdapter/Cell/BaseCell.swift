//
//  BaseCell.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

protocol AnyCellType: UITableViewCell {
    
    func fill(with model: Any, eventHandler: Handler<Any>?)
}

open class BaseCell<Model, Event>: UITableViewCell, AnyCellType {
    
    // MARK: - Properties
    
    public var eventHandler: Handler<Event>?
    
    // MARK: - View Lifycycle
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    open override func prepareForReuse() {
        self.eventHandler = nil
        
        super.prepareForReuse()
    }
    
    //MARK: - AnyCellType
    
    public func fill(with model: Any, eventHandler: Handler<Any>?) {
        if let value = model as? Model {
            self.eventHandler = {
                eventHandler?($0)
            }
            
            self.fill(with: value)
        }
    }
    
    open func fill(with model: Model) {

    }
}
