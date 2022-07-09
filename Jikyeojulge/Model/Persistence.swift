//
//  Persistence.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Eddy.Jikyeojulge")!
        let storeURL = containerURL.appendingPathComponent("Jikyeojulge.sqlite")
        let description = NSPersistentStoreDescription(url: storeURL)

        container = NSPersistentContainer(name: "Jikyeojulge")
        
        container.persistentStoreDescriptions = [description]
        
        if inMemory {
            
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

