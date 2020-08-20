//
//  CoreDataStorable.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import CoreData

protocol CoreDataStorable: Identifiable {  //  class only protocol
    
    associatedtype ManagedObject: NSManagedObject, Identifiable
    
    func coreDataModel(with context: NSManagedObjectContext) -> ManagedObject
    static func create(from managedObject: ManagedObject) -> Self?
}
