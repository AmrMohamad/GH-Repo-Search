//
//  GitHubRepositoriesPresenter.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 12/01/2024.
//

import UIKit

protocol GitHubRepositoriesPresenterProtocol {
    func viewDidLoad()
}

class GitHubRepositoriesPresenter: GitHubRepositoriesPresenterProtocol {
    weak var view: GitHubRepositoryViewProtocol?
    
    init(view: GitHubRepositoryViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        // Declare arrays to store repository URLs and information
        var reposURLs: [RepositoryURL] = []
        var repos: [Repository] = []

        // Step 1: Fetch repository URLs
        fetchRepos { result in
            switch result {
            case .success(let fetchedReposURLs):
                // Step 2: When repository URLs are successfully fetched, store them
                reposURLs = fetchedReposURLs
                // Step 3: Start fetching repository information one at a time
                self.fetchRepoInfoSequentially(index: 0, reposURLs: reposURLs, repos: repos)
                
            case .failure(let error):
                // Handle the case where fetching repository URLs fails
                print("Error fetching repositories: \(error.localizedDescription)")
            }
        }
    }

    // Function to fetch repository URLs
    private func fetchRepos(completion: @escaping (Result<[RepositoryURL], Error>) -> Void) {
        // Use GitHubAPIManager to asynchronously fetch repository URLs
        GitHubAPIManager.shared.fetchReposWith { reposURL, error in
            if let reposURL = reposURL {
                // If successful, provide the fetched repository URLs to the completion handler
                completion(.success(reposURL))
            } else if let error = error {
                // If an error occurs, provide the error to the completion handler
                completion(.failure(error))
            }
        }
    }

    // Function to fetch repository information sequentially
    private func fetchRepoInfoSequentially(index: Int, reposURLs: [RepositoryURL], repos: [Repository]) {
        // Check if we've fetched information for all repository URLs
        guard index < reposURLs.count else {
            // If all repository info requests are completed, show the repositories and print a message
            self.view?.showRepositories(repos)
            print("All processes of fetching repos completed")
            return
        }

        // Get the current repository URL
        let repoURL = reposURLs[index]

        // Fetch repository information for the current URL
        GitHubAPIManager.shared.fetchInfoOfRepoWith(url: repoURL.url) { repository, error in
            if let repository = repository {
                // If successful, add the fetched repository information to the array
                var updatedRepos = repos
                updatedRepos.append(repository)

                // Continue to the next repository URL
                self.fetchRepoInfoSequentially(index: index + 1, reposURLs: reposURLs, repos: updatedRepos)
            } else if let error = error {
                // If an error occurs, print the error and continue to the next repository URL
                print("Error fetching repository info: \(error.localizedDescription)")

                // Continue to the next repository URL even if there's an error
                self.fetchRepoInfoSequentially(index: index + 1, reposURLs: reposURLs, repos: repos)
            }
        }
    }


}
