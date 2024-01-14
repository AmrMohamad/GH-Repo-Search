//
//  CoreDataManager.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 14/01/2024.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}    
    // MARK: - CRUD Operations
    
    func saveRepository(id: Int, name: String, url: String, createdAt: Date? = nil) {
        let repository = RepositroyCD(context: context)
        repository.id = Int16(id)
        repository.name = name
        repository.url = url
        
        repository.createdAt = createdAt
        saveContext()
    }
    
    func fetchAllRepositories() -> [RepositroyCD] {
        let fetchRequest: NSFetchRequest<RepositroyCD> = RepositroyCD.fetchRequest()
        
        do {
            let repositories = try context.fetch(fetchRequest)
            return repositories
        } catch {
            print("Error fetching repositories: \(error)")
            return []
        }
    }
    
    func updateRepository(_ repository: RepositroyCD, withName name: String) {
        repository.name = name
        saveContext()
    }
    
    func deleteRepository(_ repository: RepositroyCD) {
        context.delete(repository)
        saveContext()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
