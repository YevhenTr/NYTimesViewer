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

    @discardableResult
    func save(object: Value) -> Bool {
        let _ = object.coreDataModel(with: self.context)
        
        return self.saveContext()
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
    
    @discardableResult
    func deleteObject(id: Int) -> Bool {
        let request = self.requestToFindObjects(with: id)
        var isDeleted = false
        
        (try? self.context.fetch(request))?
            .first
            .map {
                self.context.delete($0)
                do {
                    isDeleted = true
                    try self.context.save()
                } catch {
                    isDeleted = false
                }
            }
        
        return isDeleted
    }
    
    func requestToFindObjects(with id: Int) -> NSFetchRequest<CoreDataObject> {
        let request = self.emptyRequest
        
        request.predicate = NSPredicate(format: "id == %ld", id)
        
        return request
    }

    @discardableResult
    func saveContext() -> Bool {
        let context = persistentContainer.viewContext
        var isSaved = false
        
        if context.hasChanges {
            do {
                isSaved = true
                try context.save()
            } catch {
                isSaved = false
            }
        }
        
        return isSaved
    }

    func deleteAllRecords() {
        (try? self.context.fetch(self.emptyRequest))?
            .forEach { self.context.delete($0) }

        self.saveContext()
    }
}
