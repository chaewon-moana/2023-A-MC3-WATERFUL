//
//  PersistenceContainer.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/12.
//

import Foundation
import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "GitSetKit")
        container.loadPersistentStores { _, error in
            if let error = error {
                print(#function, error)
            }
        }
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(#function, error)
            }
        }
    }
}
