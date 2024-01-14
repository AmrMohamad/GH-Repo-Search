//
//  GitHubRepositoriesPresenter.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 12/01/2024.
//

import UIKit
import RealmSwift

protocol GitHubRepositoriesPresenterProtocol {
    func viewDidLoadOfViewRepositories()
    func showDetailsOf(repository: Repository)
    func returnRepositoriesCount() -> Int
    func getUsedRepository(at row:Int) -> Repository
    func willDisplayRepository(at row:Int)
    func loadItems(withQuery query: String?)
    func resetPagination()
    var repoPerPage: Int { get set }
    func setPagination(reposPerPage: Int)
}

typealias GitHubRepositoryView = GitHubRepositoryViewProtocol & UIViewController


class GitHubRepositoriesPresenter: GitHubRepositoriesPresenterProtocol {
    
    
    private weak var viewRepositories: GitHubRepositoryView?
    let realm = try! Realm()
    //MARK: - Data
    var repos: [Repository] = []
    var reposDetails: [String :RepositoryDetails] = [:]
    //MARK: - Pagination
    var _repoPerPage: Int = 10
    
    var repoPerPage: Int {
        get {
            return _repoPerPage
        }
        set {
            _repoPerPage = newValue
        }
    }
    var limitForNumberOfRepos = 10
    var paginationRepos: [Repository] = []
    
    
    init(view: GitHubRepositoryView) {
        self.viewRepositories = view
    }
    
    func viewDidLoadOfViewRepositories() {
        GitHubAPIManager.shared.fetchReposWith { [weak self] repositories, error in
            guard let repos = repositories else {return}
            self?.repos = repos  // Update the repos array in the presenter
            self?.limitForNumberOfRepos = repos.count
            for index in 0..<10 {
                self!.paginationRepos.append(repos[index])
            }
            self?.viewRepositories?.showRepositories(repos)
        }
    }
    
    func showDetailsOf(repository: Repository) {
        let vc = RepositoryDetailsViewController()
        let repoDetailsPresenter = RepositoryDetailsPresenter(repository: repository, view: vc)
        vc.presenter = repoDetailsPresenter
        self.viewRepositories?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func returnRepositoriesCount() -> Int {
        return paginationRepos.count
    }
    
    func getUsedRepository(at row:Int) -> Repository {
        return paginationRepos[row]
    }
    
    func willDisplayRepository(at row:Int) {
        if row == paginationRepos.count - 1 {
            addNewRepositories()
        }
    }
    //MARK: - Pagination Implementation
    /// Sets up pagination for repositories based on the specified number of repositories per page.
    private func addNewRepositories() {
        // Ensure that reposPerPage is within the valid range.
        guard repoPerPage < limitForNumberOfRepos else { return }
        
        let remainingRepos = limitForNumberOfRepos - repoPerPage
        
        if remainingRepos <= 10 {
            // If there are fewer than 10 remaining repositories, add all of them.
            paginationRepos += repos[repoPerPage..<limitForNumberOfRepos]
            repoPerPage = limitForNumberOfRepos
        } else {
            // If there are more than 10 remaining repositories, add the next 10.
            let endIndex = min(repoPerPage + 10, repos.count)
            guard repoPerPage < endIndex else {
                // Ensure that repoPerPage is still within the valid range.
                return
            }
            paginationRepos += repos[repoPerPage..<endIndex]
            repoPerPage += 10
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.viewRepositories?.reloadReposTableView()
        }
    }
    
    func setPagination(reposPerPage: Int) {
        // Ensure that reposPerPage is within the valid range.
        guard repoPerPage < limitForNumberOfRepos else { return }
        
        let remainingRepos = limitForNumberOfRepos - repoPerPage
        
        if remainingRepos <= 10 {
            // If there are fewer than 10 remaining repositories, add all of them.
            paginationRepos += repos[repoPerPage..<limitForNumberOfRepos]
            repoPerPage = limitForNumberOfRepos
        } else {
            // If there are more than 10 remaining repositories, add the next 10.
            let endIndex = min(repoPerPage + 10, repos.count)
            guard repoPerPage < endIndex else {
                // Ensure that repoPerPage is still within the valid range.
                return
            }
            paginationRepos += repos[repoPerPage..<endIndex]
            repoPerPage += 10
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.viewRepositories?.reloadReposTableView()
        }
    }
    func resetPagination() {
        repoPerPage = 10
        paginationRepos.removeAll()
        if repoPerPage < repos.count {
            paginationRepos = Array(repos.prefix(upTo: repoPerPage))
        } else {
            paginationRepos = repos
        }
        viewRepositories?.reloadReposTableView()
    }
    
    func loadItems(withQuery query: String?) {
        do {
            var results: Results<RepositoryRealm>
            
            // Check if a search query is provided and has at least 2 characters
            if let searchQuery = query, searchQuery.count >= 2 {
                // Use the searchRepositories method if the search query is valid; otherwise, fetch all items
                results = DatabaseManager.shared.searchRepositories(query: searchQuery) ?? realm.objects(RepositoryRealm.self)
            } else {
                // Fetch all items if no search query or an invalid search query is provided
                results = realm.objects(RepositoryRealm.self)
            }
            
            // Sort the results by the repository id in ascending order
            let sortedResults = results.sorted(byKeyPath: "id", ascending: true)
            repos = []
            
            // Iterate through the sorted results and convert them to Repository model
            for i in sortedResults {
                repos.append(
                    Repository(
                        id: i.id,
                        name: i.name,
                        fullName: i.fullName,
                        owner: Owner(
                            username: i.owner?.username ?? "",
                            avaterImageURL: i.owner?.avaterImageURL ?? ""
                        ),
                        htmlURL: i.htmlURL,
                        description: i.description,
                        url: i.url,
                        language: i.language,
                        forks: i.forks,
                        watchers: i.watchers
                    )
                )
            }
            
            // Update the pagination and reload the repository table view in the view
            updatePagination()
            viewRepositories?.reloadReposTableView()
            
        } catch {
            // Print an error message if an exception occurs while loading items
            print("Error loading items: \(error)")
        }
    }
    
    private func updatePagination() {
        guard repoPerPage < repos.count else {
            // If repoPerPage exceeds the total number of repositories, reset pagination.
            paginationRepos = repos
            return
        }
        
        // Update paginationRepos based on repoPerPage
        paginationRepos = Array(repos.prefix(upTo: repoPerPage))
    }
    
}
