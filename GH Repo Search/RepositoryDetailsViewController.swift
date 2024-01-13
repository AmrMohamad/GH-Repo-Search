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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addViews()
        
        presenter?.viewDidLoadOfRepositoryDetailsView()
    }

    private func addViews(){
        view.addSubview(avaterImageView)
        view.addSubview(userNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            avaterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avaterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            avaterImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.14),
            avaterImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28),
            
            userNameLabel.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: 6),
            userNameLabel.topAnchor.constraint(equalTo: avaterImageView.topAnchor, constant: 2),
            
            nameLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: avaterImageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: avaterImageView.bottomAnchor, constant: 16),
        ])
    }
    
    func showRepositoryInDetails(repo: Repository) {
        DispatchQueue.main.async {
            ImageLoader.shared.loadImage(withURL: repo.owner.avaterImageURL, into: self.avaterImageView)
            self.userNameLabel.text = repo.owner.username
        }
    }
}
