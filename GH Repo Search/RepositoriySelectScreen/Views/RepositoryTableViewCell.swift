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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avaterImageView)
        contentView.addSubview(repoName)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            avaterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.70),
            avaterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            avaterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avaterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            repoName.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: 12),
            repoName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            contentView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
