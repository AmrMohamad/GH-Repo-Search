//
//  DatabaseManager.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 14/01/2024.
//

import Foundation
import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {}
    
    func getCachedRepositories() -> [Repository] {
        do {
            let realm = try Realm()
            let repositoriesRealm = realm.objects(RepositoryRealm.self)
            
            let repositories: [Repository] = repositoriesRealm.map { repositoryRealm in
                return Repository(
                    id: repositoryRealm.id,
                    name: repositoryRealm.name,
                    fullName: repositoryRealm.fullName,
                    owner: Owner(username: repositoryRealm.owner?.username ?? "", avaterImageURL: repositoryRealm.owner?.avaterImageURL ?? ""),
                    htmlURL: repositoryRealm.htmlURL,
                    description: repositoryRealm.repoDescription,
                    url: repositoryRealm.url
                )
            }
            
            return repositories
        } catch {
            // Handle the error
            return []
        }
    }
    
    func saveRepositoriesToRealm(_ repositories: [Repository]) {
        do {
            let realm = try Realm()
            try realm.write {
                // Convert Repository objects to RepositoryRealm and add them to Realm
                let repositoriesRealm = repositories.map { RepositoryRealm(repository: $0) }
                realm.add(repositoriesRealm, update: .all)
            }
        } catch {
            // Handle the error
        }
    }
}
