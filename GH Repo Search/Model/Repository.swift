//
//  RepositoryDetails.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 13/01/2024.
//

import Foundation
import RealmSwift

struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String
    let owner: Owner
    let htmlURL: String
    let description: String?
    let url: String
    let language: String?
    let forks: Int?
    let watchers: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, owner, url,forks, watchers
        case fullName = "full_name"
        case htmlURL = "html_url"
        case description = "description"
        case language = "language"
    }
    
}

struct RepositoryDetails: Codable {
    let createdAt: String?
    let language: String?
    let forks: Int
    let watchers: Int
    
    enum CodingKeys: String, CodingKey {
        case forks, watchers
        case createdAt = "created_at"
        case language = "language"
    }
    
}

class RepositoryRealm: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var fullName: String = ""
    @Persisted var owner: OwnerRealm? // Link to OwnerRealm object
    @Persisted var htmlURL: String = ""
    @Persisted var repoDescription: String?
    @Persisted var url: String = ""
    @Persisted var createdAt: String?
    @Persisted var language: String?
    @Persisted var forks: Int?
    @Persisted var watchers: Int?

    convenience init(repository: Repository) {
        self.init()
        self.id = repository.id
        self.name = repository.name
        self.fullName = repository.fullName
        self.owner = OwnerRealm(owner: repository.owner)
        self.htmlURL = repository.htmlURL
        self.repoDescription = repository.description
        self.url = repository.url
    }
}
