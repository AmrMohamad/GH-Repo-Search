//
//  MainViewController+UITableViewDataSource.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 12/01/2024.
//

import UIKit

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as! RepositoryTableViewCell
        let repoItem = paginationRepos[indexPath.row]
        
        ImageLoader.shared.loadImage(withURL: repoItem.owner.avaterImageURL, into: cell.avaterImageView)
        cell.avaterImageView.contentMode = .scaleAspectFill
        cell.repoName.text = repoItem.name
        cell.ownerLabel.text = "Owner: \(repoItem.owner.username)"

        return cell
    }
}
