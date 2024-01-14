//
//  ViewController.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 11/01/2024
//

import UIKit
import RealmSwift

protocol GitHubRepositoryViewProtocol: AnyObject {
    func showRepositories(_ repositories: [Repository])
}

class MainViewController: UIViewController, GitHubRepositoryViewProtocol{
        
    var presenter: GitHubRepositoriesPresenterProtocol?
    let realm = try! Realm()
    var reposRealm: Results<RepositoryRealm>?
    //MARK: - UI elements
    let tableView: UITableView = {
        let table = UITableView()
        table.register(
            RepositoryTableViewCell.self,
            forCellReuseIdentifier: RepositoryTableViewCell.identifier
        )
        return table
    }()
    
    let search = UISearchController(searchResultsController: nil)
    
    let loadingView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    lazy var footerSpinnerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 120))
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        return view
    }()
    
    lazy var headerSpinnerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 120))
        view.addSubview(loadingView)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please wait few seconds, We are preparing the repositories for you"
        label.textAlignment = .center
        label.numberOfLines = 0
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: loadingView.bottomAnchor, constant: 4),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60)
        ])
        return view
    }()
    
    //MARK: - Data
    var repos: [Repository] = []
    var reposDetails: [String :RepositoryDetails] = [:]
    //MARK: - Pagination
    var repoPerPage = 10
    var limitForNumberOfRepos = 10
    var paginationRepos: [Repository] = []
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        presenter = GitHubRepositoriesPresenter(view: self)
        view.backgroundColor = .systemBackground
        title = "GitHub Repositories"
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        search.delegate = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        
        presenter?.viewDidLoadOfViewRepositories()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
        tableView.isUserInteractionEnabled = false
        tableView.tableHeaderView = headerSpinnerView
        loadingView.startAnimating()
        
    }
    

    func showRepositories(_ repositories: [Repository]) {
        repos = repositories
        limitForNumberOfRepos = repos.count
        for index in 0..<10 {
            self.paginationRepos.append(repos[index])
        }
        DispatchQueue.main.async {
            self.tableView.tableHeaderView = nil
            self.tableView.isUserInteractionEnabled = true
            self.tableView.reloadData()
        }
    }
    
    func retrieveCreationDate(for url: String) {
        if let cachedDate = reposDetails[url] {
            print("Already cached: \(cachedDate)")
        } else {
            print(url)

            // Get the existing object from Realm based on URL
            if let existingRepository = realm.objects(RepositoryRealm.self).filter("url == %@", url).first {
                // Check if createdAt is nil in Realm
                if existingRepository.createdAt != nil {
                    // createdAt is not nil in Realm, use the value
                    self.reposDetails[url] = RepositoryDetails(createdAt: existingRepository.createdAt!)
                    self.tableView.reloadData()
                    return
                } else {
                    // createdAt is nil in Realm
                    print("createdAt is nil in Realm")
                }
            }

            // Fetch data from API
            GitHubAPIManager.shared.fetchMoreDetailsForRepoWith(url) { [weak self] repositoryDetails in
                if let repoDetails = repositoryDetails {
                    DispatchQueue.main.async {
                        // Get the existing object from Realm based on URL
                        if let existingRepository = self?.realm.objects(RepositoryRealm.self).filter("url == %@", url).first {
                            // Update only the createdAt property
                            do {
                                try self?.realm.write {
                                    existingRepository.createdAt = repoDetails.createdAt
                                }
                            } catch {
                                print("Error updating createdAt in Realm: \(error)")
                            }
                        }

                        // Update the cache
                        self?.reposDetails[url] = repoDetails

                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }



    //MARK: - Pagination Implementation
    /// Sets up pagination for repositories based on the specified number of repositories per page.
    ///
    /// - Parameter reposPerPage: The number of repositories to display per page.
    func setPagination (reposPerPage: Int) {
        // Ensure that reposPerPage is within the valid range.
        guard reposPerPage < limitForNumberOfRepos else {return}
        
        // Check if reposPerPage is within the last 10 repositories.
        if reposPerPage >= limitForNumberOfRepos - 10 {
            // If true, add the remaining repositories from reposPerPage to the end of the array.
            for i in reposPerPage..<limitForNumberOfRepos {
                paginationRepos.append(repos[i])
            }
            // Update repoPerPage to keep track of the last displayed repository index.
            self.repoPerPage += 10
        } else {
            // If reposPerPage is not within the last 10 repositories,
            // add the next 10 repositories starting from reposPerPage.
            for i in reposPerPage..<reposPerPage + 10 {
                paginationRepos.append(repos[i])
            }
            // Update repoPerPage to keep track of the last displayed repository index.
            repoPerPage += 10
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

