//
//  RepositoryDetailedPresenter.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 13/01/2024.
//

import UIKit

protocol RepositoryDetailedPresenterProtocol {
    func viewDidLoad()
}

class RepositoryDetailsPresenter: RepositoryDetailedPresenterProtocol {
    
    weak var view: RepositoryDetailedViewProtocol?
    var repository: Repository?

    init(view: RepositoryDetailedViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        // Update the details view with repository details
        
    }
}
