//
//  MainViewController+SearchHandling.swift
//  GH Repo Search
//
//  Created by Amr Mohamad on 14/01/2024.
//

import UIKit
import RealmSwift


extension MainViewController : UISearchBarDelegate,UISearchControllerDelegate {
    
    func loadItems(withQuery query: String?) {
        presenter?.loadItems(withQuery: query)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadItems(withQuery: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Called when the cancel button in the search bar is clicked
        // Load all items
        loadItems(withQuery: nil)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Called when the search button in the keyboard is clicked
        searchBar.resignFirstResponder()
    }
    
    

}
