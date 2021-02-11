//
//  SearchBarItem.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 1/19/21.
//  Copyright © 2021 Mikalai Kuts. All rights reserved.
//

import Foundation
import UIKit

class SearchBarItem: UIViewController, UISearchResultsUpdating{
    
    var tableView = UITableView()
    var entries: [String] = []
    var searchController = UISearchController()
    var searchResult: [String] = []
    
    func setUpSearchBar(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.isActive = true
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    func filterContent(for searchText: String) {
        searchResult = entries.filter({ (title: String) -> Bool in
            let match = title.range(of: searchText, options: .caseInsensitive)
            return match != nil
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
}
