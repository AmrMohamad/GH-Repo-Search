//
//  ViewController.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 11/01/2024
//

import UIKit

protocol GitHubRepositoryViewProtocol: AnyObject {
    func showRepositories(_ repositories: [Repository])
}

class MainViewController: UIViewController,
    GitHubRepositoryViewProtocol,
    UITableViewDataSource,
    UITableViewDelegate {
    
    var presenter: GitHubRepositoriesPresenterProtocol?
    
    //MARK: - UI elements
    let tableView: UITableView = {
        let table = UITableView()
        table.register(
            RepositoryTableViewCell.self,
            forCellReuseIdentifier: RepositoryTableViewCell.identifier
        )
        return table
    }()
    
    //MARK: - Data
    var repos: [Repository] = []
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter = GitHubRepositoriesPresenter(view: self)
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    

    func showRepositories(_ repositories: [Repository]) {
        repos = repositories
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as! RepositoryTableViewCell
        let repoItem = repos[indexPath.row]
        cell.repoName.text = repoItem.name
        return cell
    }
}

