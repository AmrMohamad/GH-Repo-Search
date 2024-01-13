//
//  GitHubRepositoriesPresenter.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 12/01/2024.
//

import UIKit

protocol GitHubRepositoriesPresenterProtocol {
    func viewDidLoadOfViewRepositories()
    func showDetailsOf(repository: Repository)
}

typealias GitHubRepositoryView = GitHubRepositoryViewProtocol & UIViewController


class GitHubRepositoriesPresenter: GitHubRepositoriesPresenterProtocol {
    
    
    private weak var viewRepositories: GitHubRepositoryView?
    
    init(view: GitHubRepositoryView) {
        self.viewRepositories = view
    }
    
    func viewDidLoadOfViewRepositories() {
        GitHubAPIManager.shared.fetchReposWith { [weak self] repositories, error in
            guard let repos = repositories else {return}
            self?.viewRepositories?.showRepositories(repos)
        }
    }

    func showDetailsOf(repository: Repository) {
        let vc = RepositoryDetailsViewController()
        let repoDetailsPresenter = RepositoryDetailsPresenter(repository: repository, view: vc)
        vc.presenter = repoDetailsPresenter
        self.viewRepositories?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
