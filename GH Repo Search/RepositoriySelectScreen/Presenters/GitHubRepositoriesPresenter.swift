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
        GitHubAPIManager.shared.fetchReposWith { [weak self] repositories, error in
            if let ropes = repositories {
                self?.view?.showRepositories(ropes)
            }
        }
    }
}
