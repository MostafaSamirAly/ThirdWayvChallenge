//
//  File.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 09/02/2022.
//

import CoreData

final class CoreDataConfiguration {

    static let shared = CoreDataConfiguration()
    
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ThirdWayvChallenge")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // TODO: - Log
                assertionFailure("CoreDataConfiguration Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // TODO: - Log 
                assertionFailure("CoreDataConfiguration Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
