//
//  SearchArticlesResultsViewController.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

final class SearchArticlesResultsViewController: UIViewController {
    var viewModel: SearchArticlesResultsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
}

// MARK: - UISearchResultsUpdating

extension SearchArticlesResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
        debugPrint(">>>> %@", searchController.searchBar.text)
    }
}

// MARK: - Privates

extension SearchArticlesResultsViewController {
    fileprivate func setupViewModel() {
    }
}
