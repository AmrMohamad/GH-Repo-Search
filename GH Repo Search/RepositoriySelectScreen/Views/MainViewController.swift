//
//  ViewController.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 11/01/2024
//

import UIKit

protocol GitHubRepositoryViewProtocol {
    func showRepositories(_ repositories: [Repository])
}

class MainViewController: UIViewController, GitHubRepositoryViewProtocol {
    
    let tableView: UITableView = {
        let table = UITableView()
        
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
    }

    func showRepositories(_ repositories: [Repository]) {
        GitHubAPIManager.shared.fetchReposWith()
    }
}

