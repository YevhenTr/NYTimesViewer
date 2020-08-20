//
//  BaseStorageService.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import CoreData

//  *.xcdatamodeld file should have same name as file Model
//  core data model should confirm Identifiable

class BaseStorageService<Value: CoreDataStorable> {
    
    // MARK: - Subtypes
    
    typealias CoreDataObject = Value.ManagedObject
    
    // MARK: - Properties

    public let storagePath: String
    public var context: NSManagedObjectContext { return self.persistentContainer.viewContext }
    public var emptyRequest: NSFetchRequest<CoreDataObject> { return NSFetchRequest(entityName: String(describing: CoreDataObject.self)) }
    
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: String(describing: Value.self))
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Init and Deinit
    
    init(storagePath: String = libraryFolderPath()) {
        self.storagePath = storagePath
    }
    
    // MARK: - Public API
    
    func isStored(fileID: Int) -> Bool {
        return self.readObject(id: fileID) == nil ? false : true
    }

    func save(object: Value) {
        let _ = object.coreDataModel(with: self.context)
        self.saveContext()
    }
    
    func readObject(id: Int) -> Value? {
        let request = self.requestToFindObjects(with: id)

        return (try? self.context.fetch(request))?
            .compactMap { Value.create(from: $0) }
            .first
    }

    func readAllObjects() -> [Value]? {
        return (try? self.context.fetch(self.emptyRequest))?
            .compactMap { Value.create(from: $0) }
    }

    //  should be overriden
    func udpate(newObject: Value) {
        /*
        let request = self.requestToFindObjects(with: newObject.ID)
        let currentObject = try? self.context.fetch(request).first
        
        currentObject.do {
            $0.field_1 = newObject.field_1
            $0.field_2 = newObject.field_2
            ...
        }
         
        self.saveContext()
        */
    }
    
    func deleteObject(id: Int) {
        let request = self.requestToFindObjects(with: id)

        (try? self.context.fetch(request))?
            .first
            .map {
                self.context.delete($0)
                try? self.context.save()
            }
    }
    
    func requestToFindObjects(with id: Int) -> NSFetchRequest<CoreDataObject> {
        let request = self.emptyRequest
        
        request.predicate = NSPredicate(format: "id == %ld", id)
        
        return request
    }

    func saveContext() {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            try? context.save()
        }
    }

    func deleteAllRecords() {
        (try? self.context.fetch(self.emptyRequest))?
            .forEach { self.context.delete($0) }

        self.saveContext()
    }
}
