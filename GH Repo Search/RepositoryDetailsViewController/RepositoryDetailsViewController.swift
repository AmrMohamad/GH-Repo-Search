//
//  RepositoryDetailedViewController.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 13/01/2024.
//
import RealmSwift
import UIKit

protocol RepositoryDetailsViewProtocol: AnyObject {
    func showRepositoryInDetails(repo: Repository)
}

class RepositoryDetailsViewController: UIViewController, RepositoryDetailsViewProtocol {
    
    var presenter: RepositoryDetailsPresenterProtocol?
    let realm = try! Realm()
    
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
    let forksDetailsTitlelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Repository Details"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let watchersDetailsTitlelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Repository Details"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let languageDetailsTitlelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Repository Details"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
        let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray2
        imageView.layer.cornerRadius = 14
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
        repoDetailsContainerView.addSubview(forksDetailsTitlelabel)
        repoDetailsContainerView.addSubview(watchersDetailsTitlelabel)
        repoDetailsContainerView.addSubview(languageDetailsTitlelabel)
        view.addSubview(ownerDetailsContainerView)
        ownerDetailsContainerView.addSubview(ownerTitlelabel)
        ownerDetailsContainerView.addSubview(avaterImageView)
        ownerDetailsContainerView.addSubview(userNameLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            repoDetailsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repoDetailsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            repoDetailsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.42),
            repoDetailsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
            
            ownerDetailsContainerView.leadingAnchor.constraint(equalTo: repoDetailsContainerView.leadingAnchor),
            ownerDetailsContainerView.topAnchor.constraint(equalTo: repoDetailsContainerView.bottomAnchor, constant: 18),
            ownerDetailsContainerView.trailingAnchor.constraint(equalTo: repoDetailsContainerView.trailingAnchor),
            ownerDetailsContainerView.heightAnchor.constraint(equalTo: repoDetailsContainerView.heightAnchor, multiplier: 0.40)
        ])
        
        NSLayoutConstraint.activate([
            repoDetailsTitlelabel.leadingAnchor.constraint(equalTo: repoDetailsContainerView.leadingAnchor, constant: 10),
            repoDetailsTitlelabel.topAnchor.constraint(equalTo: repoDetailsContainerView.topAnchor, constant: 5),
            repoDetailsTitlelabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: repoDetailsTitlelabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: repoDetailsContainerView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: repoDetailsTitlelabel.bottomAnchor, constant: 4),
            
            forksDetailsTitlelabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            forksDetailsTitlelabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            
            watchersDetailsTitlelabel.leadingAnchor.constraint(equalTo: forksDetailsTitlelabel.leadingAnchor),
            watchersDetailsTitlelabel.topAnchor.constraint(equalTo: forksDetailsTitlelabel.bottomAnchor, constant: 4),
            
            languageDetailsTitlelabel.leadingAnchor.constraint(equalTo: watchersDetailsTitlelabel.leadingAnchor),
            languageDetailsTitlelabel.topAnchor.constraint(equalTo: watchersDetailsTitlelabel.bottomAnchor, constant: 4),
            
        ])
        
        NSLayoutConstraint.activate([
            ownerTitlelabel.leadingAnchor.constraint(equalTo: ownerDetailsContainerView.leadingAnchor, constant: 10),
            ownerTitlelabel.topAnchor.constraint(equalTo: ownerDetailsContainerView.topAnchor, constant: 5),
            ownerTitlelabel.heightAnchor.constraint(equalToConstant: 20),
            
            avaterImageView.leadingAnchor.constraint(equalTo: ownerTitlelabel.leadingAnchor),
            avaterImageView.topAnchor.constraint(equalTo: ownerTitlelabel.bottomAnchor, constant: 4),
            avaterImageView.heightAnchor.constraint(equalTo: ownerDetailsContainerView.heightAnchor, multiplier: 0.70),
            avaterImageView.widthAnchor.constraint(equalTo: ownerDetailsContainerView.widthAnchor, multiplier: 0.36),
            
            userNameLabel.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: 8),
            userNameLabel.topAnchor.constraint(equalTo: avaterImageView.topAnchor, constant: 2)
        ])
    }
    
    func showRepositoryInDetails(repo: Repository) {
        DispatchQueue.main.async {
            self.title = repo.name
            
            // Read repository details from the database
            if let repositoryRealm = self.realm.objects(RepositoryRealm.self).filter("id == %@", repo.id).first {
                ImageLoader.shared.loadImage(withURL: repositoryRealm.owner!.avaterImageURL , into: self.avaterImageView)
                self.userNameLabel.text = repositoryRealm.owner?.username
                self.descriptionLabel.text = repositoryRealm.repoDescription ?? "No description available"
                self.forksDetailsTitlelabel.text = "Forks: \(repositoryRealm.forks!)"
                self.watchersDetailsTitlelabel.text = "Watchers: \(repositoryRealm.watchers!)"
                self.languageDetailsTitlelabel.text = "Language: \(repositoryRealm.language!)"
                dump(repositoryRealm)
            }
        }
    }
}

