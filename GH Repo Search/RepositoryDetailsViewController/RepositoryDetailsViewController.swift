//
//  RepositoryDetailedViewController.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 13/01/2024.
//

import UIKit

protocol RepositoryDetailsViewProtocol: AnyObject {
    func showRepositoryInDetails(repo: Repository)
}

class RepositoryDetailsViewController: UIViewController, RepositoryDetailsViewProtocol {
    
    var presenter: RepositoryDetailsPresenterProtocol?
    
    //MARK: - UI elements
    let repoDetailsTitlelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Repository Details"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    let repoDetailsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowRadius = 3.0
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        return view
    }()
    
    let ownerTitlelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Owner"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let ownerDetailsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowRadius = 3.0
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        return view
    }()

    let avaterImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        addViews()
        
        presenter?.viewDidLoadOfRepositoryDetailsView()
    }

    private func addViews(){
        view.addSubview(repoDetailsContainerView)
        repoDetailsContainerView.addSubview(repoDetailsTitlelabel)
        repoDetailsContainerView.addSubview(descriptionLabel)
        view.addSubview(ownerDetailsContainerView)
        ownerDetailsContainerView.addSubview(ownerTitlelabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            repoDetailsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repoDetailsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            repoDetailsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.62),
            repoDetailsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
            
            ownerDetailsContainerView.leadingAnchor.constraint(equalTo: repoDetailsContainerView.leadingAnchor),
            ownerDetailsContainerView.topAnchor.constraint(equalTo: repoDetailsContainerView.bottomAnchor, constant: 18),
            ownerDetailsContainerView.trailingAnchor.constraint(equalTo: repoDetailsContainerView.trailingAnchor),
            ownerDetailsContainerView.heightAnchor.constraint(equalTo: repoDetailsContainerView.heightAnchor, multiplier: 0.20)
        ])
        
        NSLayoutConstraint.activate([
            repoDetailsTitlelabel.leadingAnchor.constraint(equalTo: repoDetailsContainerView.leadingAnchor, constant: 10),
            repoDetailsTitlelabel.topAnchor.constraint(equalTo: repoDetailsContainerView.topAnchor, constant: 5),
            repoDetailsTitlelabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: repoDetailsTitlelabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: repoDetailsContainerView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: repoDetailsTitlelabel.bottomAnchor, constant: 4),
            
        ])
        
        NSLayoutConstraint.activate([
            ownerTitlelabel.leadingAnchor.constraint(equalTo: ownerDetailsContainerView.leadingAnchor, constant: 10),
            ownerTitlelabel.topAnchor.constraint(equalTo: ownerDetailsContainerView.topAnchor, constant: 5),
            ownerTitlelabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func showRepositoryInDetails(repo: Repository) {
        DispatchQueue.main.async {
            self.title = repo.name
            ImageLoader.shared.loadImage(withURL: repo.owner.avaterImageURL, into: self.avaterImageView)
            self.userNameLabel.text = repo.owner.username
            self.descriptionLabel.text = repo.description!
        }
    }
}

