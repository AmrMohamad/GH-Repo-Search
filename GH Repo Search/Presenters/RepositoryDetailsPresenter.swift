//
//  RepositoryDetailsPresenter.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 13/01/2024.
//

import UIKit

protocol RepositoryDetailsPresenterProtocol: AnyObject {
    var repository: Repository? { get set }
    func viewDidLoadOfRepositoryDetailsView()
}

typealias RepositoryDetailsView = RepositoryDetailsViewProtocol & UIViewController

class RepositoryDetailsPresenter: RepositoryDetailsPresenterProtocol {
    
    var repository: Repository?
    private weak var view : RepositoryDetailsView?
    
    init(repository: Repository? = nil, view: RepositoryDetailsView? = nil) {
        self.repository = repository
        self.view = view
    }
    
    func viewDidLoadOfRepositoryDetailsView() {
        if let repo = repository {
            view?.showRepositoryInDetails(repo: repo)
        }
    }
}
