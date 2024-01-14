//
//  Owner.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 13/01/2024.
//

import Foundation
import RealmSwift

struct Owner: Codable {
    var username: String
    var avaterImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avaterImageURL = "avatar_url"
    }
}

class OwnerRealm: Object {
    @Persisted var username: String = ""
    @Persisted var avaterImageURL: String = ""

    convenience init(owner: Owner) {
        self.init()
        self.username = owner.username
        self.avaterImageURL = owner.avaterImageURL
    }
}
