//
//  CoreDataStack.swift
//  Calorie Tracker
//
//  Created by Dojo on 10/11/20.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    private init() {}

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CalorieTracker")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    var mainContext: NSManagedObjectContext {
        container.viewContext
    }

    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var saveError: Error?

        context.performAndWait {
            do {
                try context.save()
            } catch {
                saveError = error
            }
        }

        if let saveError = saveError { throw saveError }
    }
}
