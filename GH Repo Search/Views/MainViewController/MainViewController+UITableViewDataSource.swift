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
        
        retrieveCreationDate(for: repoItem.url)
        cell.setCreatedAt(date: reposDetails[repoItem.url]?.createdAt ?? "")
        if !cell.dateOfCreationValueLabel.text!.isEmpty {
            cell.loadingView.stopAnimating()
        }
        cell.configure(name: repoItem.name, ownerName: repoItem.owner.username, avaterURL: repoItem.owner.avaterImageURL)

        return cell
    }
    
}
