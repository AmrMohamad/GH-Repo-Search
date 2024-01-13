//
//  GitHubAPIManager.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 12/01/2024.
//

import UIKit

struct GitHubAPIManager {
    static let shared = GitHubAPIManager()
    
    let ghURL = "https://api.github.com/repositories"
    
    func fetchReposWith(completion: @escaping ([Repository]?, Error?) -> Void){
        if let url = URL(string: ghURL) {
            let session = URLSession(configuration: .default)
            let task =  session.dataTask(with: url) { data, response, error in
                guard let data = data else {return}
                let decoder = JSONDecoder()
                do {
                    let repos = try decoder.decode([Repository].self, from: data)
                    print("Data:")
                    completion(repos,nil)
                }catch {

                    completion(nil,error)
                }
            }
            task.resume()
        }
    }
}
