//
//  GitHubAPIManager.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 12/01/2024.
//

import UIKit
import RealmSwift

//struct GitHubAPIManager {
//    static let shared = GitHubAPIManager()
//
//    let ghURL = "https://api.github.com/repositories"
//
//    func fetchReposWith(completion: @escaping ([Repository]?, Error?) -> Void){
//        if let url = URL(string: ghURL) {
//            let session = URLSession(configuration: .default)
//            let task =  session.dataTask(with: url) { data, response, error in
//                guard let data = data else {return}
//                let decoder = JSONDecoder()
//                do {
//                    let repos = try decoder.decode([Repository].self, from: data)
//                    completion(repos,nil)
//                }catch {
//
//                    completion(nil,error)
//                }
//            }
//            task.resume()
//        }
//    }
//}

struct GitHubAPIManager {
    static let shared = GitHubAPIManager()

    let ghURL = "https://api.github.com/repositories"

    func fetchReposWith(completion: @escaping ([Repository]?, Error?) -> Void) {
        // Check if cached data is available in Realm using DatabaseManager
        let cachedRepos = DatabaseManager.shared.getCachedRepositories()

        if !cachedRepos.isEmpty {
            // Return cached data if available
            completion(cachedRepos, nil)
            return
        }

        // Fetch data from the API if no cached data is available
        if let url = URL(string: ghURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    completion(nil, error)
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let repos = try decoder.decode([Repository].self, from: data)
                    completion(repos, nil)
                    // Save fetched data to Realm using DatabaseManager
                    DatabaseManager.shared.saveRepositoriesToRealm(repos)

                } catch {
                    completion(nil, error)
                }
            }
            task.resume()
        }
    }
    
    func fetchMoreDetailsForRepoWith(_ url: String, completion: @escaping (RepositoryDetails?) -> Void){
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let repos = try decoder.decode(RepositoryDetails.self, from: data)
                    dump(repos)
                    completion(repos)
                   

                } catch {
                    
                }
            }
            task.resume()
        }
    }
}
