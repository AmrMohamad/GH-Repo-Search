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
        cell.repoName.text = repoItem.name
        cell.ownerLabel.text = "Owner: \(repoItem.owner.username)"
        let dateString = repoItem.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            // Now 'date' contains the parsed date object
            dateFormatter.dateFormat = "dd-MM-yyy"
            cell.dateOfCreationLabel.text = "Created at: \(dateFormatter.string(from: date))"
        } else {
            // Handle the case where the date string couldn't be parsed
            cell.dateOfCreationLabel.text = "NA"
        }
        
        return cell
    }
}
