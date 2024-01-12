//
//  MainViewController+UITableViewDelegate.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 12/01/2024.
//

import UIKit

extension MainViewController:  UITableViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Ensure that the scrollView is the tableView.
        guard scrollView == tableView else {return}
        
        // Set the tableFooterView to the footerSpinnerView to indicate loading.
        tableView.tableFooterView = footerSpinnerView
        loadingView.startAnimating()
        
        // Add a delay of 1 second before performing additional operations.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Check if the user has reached the bottom of the tableView.
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height {
                // If true, trigger pagination by loading the next set of repositories.
                self.setPagination(reposPerPage: self.repoPerPage)
                
                // Reload the tableView on the main thread to reflect the changes.
                DispatchQueue.main.async{
                    // Set tableFooterView to nil to hide the loading indicator.
                    self.tableView.tableFooterView = nil
                }
            }
        }
    }
}
