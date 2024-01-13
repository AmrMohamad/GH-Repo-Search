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
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, owner, description, url
        case fullName = "full_name"
        case htmlURL = "html_url"
    }
    
//    func getCreationDate(completion: @escaping (RepositoryDetailed?,Error?)-> Void) {
//        if let url = URL(string: self.url) {
//            let session = URLSession(configuration: .default)
//            let task =  session.dataTask(with: url) { data, response, error in
//                guard let data = data else {return}
//                let decoder = JSONDecoder()
//                do {
//                    let repos = try decoder.decode(RepositoryDetailed.self, from: data)
//                    completion(repos,nil)
//                }catch {
//                    completion(nil,error)
//                }
//            }
//            task.resume()
//        }
//    }
}
