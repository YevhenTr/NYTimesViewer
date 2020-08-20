//
//  Section.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public struct SectionHeader {
    
    let view: UIView?
    let height: CGFloat
}

public struct Section {
    
    // MARK: - Properties
    
    let cell: AnyCellType.Type
    let header: SectionHeader?
    let eventHandler: ((Any) -> ())?
    let isEditing: Bool
    
    var models: [Any]
    
    // MARK: - Init and Deinit
    
    public init<Cell, Model, EventsType>(
        cell: Cell.Type,
        models: [Model],
        eventHandler: Handler<EventsType>? = nil,
        header: SectionHeader? = nil,
        isEditing: Bool = false
    )
        where Cell: BaseCell<Model, EventsType>
    {
        self.cell = cell
        self.models = models
        self.header = header
        self.isEditing = isEditing
        self.eventHandler = {
            if let event = $0 as? EventsType {
                eventHandler?(event)
            }
        }
    }
    
    public init<Cell, Model, EventsType>(
        cell: Cell.Type,
        model: Model,
        eventHandler: Handler<EventsType>? = nil,
        header: SectionHeader? = nil,
        isEditing: Bool = false
    )
        where Cell: BaseCell<Model, EventsType>
    {
        self.init(cell: cell,
                  models: [model],
                  eventHandler: eventHandler,
                  header: header,
                  isEditing: isEditing)
    }
}
