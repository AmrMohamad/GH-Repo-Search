//
//  RepositoryTableViewCell.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 12/01/2024.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    static let identifier = "RepositoryTableViewCell"
    
    //MARK: - UI elements
    let repoName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    let ownerLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    let avaterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray2
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let dateOfCreationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Created at:"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let dateOfCreationValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let loadingView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    func configure(name: String, ownerName: String, avaterURL: String) {
        ImageLoader.shared.loadImage(withURL: avaterURL, into: self.avaterImageView)
        self.avaterImageView.contentMode = .scaleAspectFill
        self.repoName.text = name
        self.ownerLabel.text = ownerName
    }
    func setCreatedAt(date: String) {
        dateOfCreationValueLabel.text = date
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avaterImageView)
        contentView.addSubview(repoName)
        contentView.addSubview(ownerLabel)
        contentView.addSubview(dateOfCreationLabel)
        contentView.addSubview(loadingView)
        contentView.addSubview(dateOfCreationValueLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        avaterImageView.contentMode = .scaleAspectFit
        avaterImageView.image = UIImage(systemName: "person.fill")
    }
    private func setConstraints(){
        NSLayoutConstraint.activate([
            avaterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.70),
            avaterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            avaterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avaterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            repoName.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: 12),
            repoName.topAnchor.constraint(equalTo: avaterImageView.topAnchor, constant: 2),
            
            ownerLabel.leadingAnchor.constraint(equalTo: repoName.leadingAnchor),
            ownerLabel.topAnchor.constraint(equalTo: repoName.bottomAnchor, constant: 6),
            
            dateOfCreationLabel.leadingAnchor.constraint(equalTo: repoName.leadingAnchor),
            dateOfCreationLabel.bottomAnchor.constraint(equalTo: avaterImageView.bottomAnchor, constant: -2),
            
            loadingView.leadingAnchor.constraint(equalTo: dateOfCreationLabel.trailingAnchor, constant: 6),
            loadingView.bottomAnchor.constraint(equalTo: dateOfCreationLabel.bottomAnchor, constant: -2),
            loadingView.heightAnchor.constraint(equalToConstant: 10),
            loadingView.widthAnchor.constraint(equalToConstant: 10),
            
            dateOfCreationValueLabel.leadingAnchor.constraint(equalTo: dateOfCreationLabel.trailingAnchor, constant: 6),
            dateOfCreationValueLabel.bottomAnchor.constraint(equalTo: dateOfCreationLabel.bottomAnchor, constant: -2),
            
            contentView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
