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
    
    // MARK: - Initializer
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "GitSetKit")
        container.loadPersistentStores { _, error in
            if let error = error {
                print(#function, error)
            }
        }
    } //: - Initializer
    
    // MARK: - Save Function
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(#function, error)
            }
        }
    } //: - Save Function
    
    // MARK: - Team CRUD
    func teamCreate(name: String, desc: String, template: String) {
        let team = Team(context: container.viewContext)
        
        team.id = UUID()
        team.name = name
        team.desc = desc
        team.template = template
        
        saveContext()
    }
    
    func teamRead(predicateFormat: String? = nil, fetchLimit: Int? = nil) -> [Team] {
        var results: [Team] = []
        
        let request = NSFetchRequest<Team>(entityName: "Team")
        
        if predicateFormat != nil {
            request.predicate = NSPredicate(format: predicateFormat!)
        }
        if fetchLimit != nil {
            request.fetchLimit = fetchLimit!
        }
        
        do {
            results = try container.viewContext.fetch(request)
        } catch {
            print("Could not fetch teams from Core Data.")
        }
        
        return results
    }
    
    func teamUpdate(team: Team, name: String? = nil, desc: String? = nil, template: String? = nil) {
        var hasChanges: Bool = false
        
        if name != nil {
            team.name = name!
            hasChanges = true
        }
        if desc != nil {
            team.desc = desc!
            hasChanges = true
        }
        if template != nil {
            team.template = template!
            hasChanges = true
        }
        
        if hasChanges {
            saveContext()
        }
    }
    
    func teamDelete(_ team: Team) {
        container.viewContext.delete(team)
        saveContext()
    } //: - Team CRUD
}
