//
//  Owner.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 13/01/2024.
//

import UIKit

struct Owner: Codable {
    var username: String
    var avaterImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avaterImageURL = "avatar_url"
    }
}
