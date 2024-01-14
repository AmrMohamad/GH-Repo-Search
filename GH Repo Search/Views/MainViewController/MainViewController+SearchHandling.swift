//
//  MainViewController+SearchHandling.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 14/01/2024.
//

import UIKit
import RealmSwift


extension MainViewController : UISearchBarDelegate,UISearchControllerDelegate {
    
    func loadItems(withQuery query: String? = nil) {
        do {
            var results: Results<RepositoryRealm>

            if let searchQuery = query, searchQuery.count >= 2 {
                results = DatabaseManager.shared.searchRepositories(query: searchQuery) ?? realm.objects(RepositoryRealm.self)
            } else {
                results = realm.objects(RepositoryRealm.self)
            }

            let sortedResults = results.sorted(byKeyPath: "id", ascending: true)
            repos = []
            for i in sortedResults {
                repos.append(
                    Repository(
                        id: i.id,
                        name: i.name,
                        fullName: i.fullName,
                        owner: Owner(
                            username: i.owner!.username,
                            avaterImageURL: i.owner!.avaterImageURL
                        ) ,
                        htmlURL: i.htmlURL,
                        description: i.description,
                        url: i.url,
                        language: i.language,
                        forks: i.forks,
                        watchers: i.watchers
                    )
                )
            }
            updatePagination()
            tableView.reloadData()

        } catch {
            print("Error loading items: \(error)")
        }
    }

    func updatePagination() {
        guard repoPerPage < repos.count else {
            // If repoPerPage exceeds the total number of repositories, reset pagination.
            paginationRepos = repos
            return
        }

        // Update paginationRepos based on repoPerPage
        paginationRepos = Array(repos.prefix(upTo: repoPerPage))
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // If the search text is empty, load all items
            loadItems()
        } else if searchText.count >= 2 {
            // If the search text has at least 2 characters, search repositories by name
            if let searchResults = DatabaseManager.shared.searchRepositories(query: searchText) {
                let results = searchResults.sorted(byKeyPath: "createdAt", ascending: true)
                repos = []
                for i in results {
                    repos.append(
                        Repository(
                            id: i.id,
                            name: i.name,
                            fullName: i.fullName,
                            owner: Owner(
                                username: i.owner!.username,
                                avaterImageURL: i.owner!.avaterImageURL
                            ) ,
                            htmlURL: i.htmlURL,
                            description: i.description,
                            url: i.url,
                            language: i.language,
                            forks: i.forks,
                            watchers: i.watchers
                        )
                    )
                }
                updatePagination()  // Add this line to update pagination after searching
                tableView.reloadData()
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Called when the cancel button in the search bar is clicked
        // Load all items
        loadItems()
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Called when the search button in the keyboard is clicked
        searchBar.resignFirstResponder()
    }
}
