//
//  RepositoryDetails.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 13/01/2024.
//

import Foundation

struct Repository: Codable {
        let id: Int
        let name: String
        let fullName: String
        let owner: Owner
        let htmlURL: String
        let description: String?
        let url: String
        let createdAt: String
        
        
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case htmlURL = "html_url"
        case description
        case url
        case createdAt = "created_at"
    }
}
