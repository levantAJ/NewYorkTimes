//
//  ArticleDetailViewController.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

final class ArticleDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ArticleDetailViewModel! {
        didSet {
            tableView?.reloadData() //tableView might hasn't loaded yet
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - UITableViewDataSource

extension ArticleDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemViewModel = viewModel.itemViewModel(at: indexPath.row)
        if let itemViewModel = itemViewModel as? ArticleTitleTableViewCellViewModel {
            let cell = tableView.dequeueReusableCell(type: ArticleTitleTableViewCell.self, for: indexPath)
            cell.set(viewModel: itemViewModel)
            return cell
        }
        if let itemViewModel = itemViewModel as? ArticleAggregateTableViewCellViewModel {
            let cell = tableView.dequeueReusableCell(type: ArticleAggregateTableViewCell.self, for: indexPath)
            cell.set(viewModel: itemViewModel)
            return cell
        }
        if let itemViewModel = itemViewModel as? ArticleSnippetTableViewCellViewModel {
            let cell = tableView.dequeueReusableCell(type: ArticleSnippetTableViewCell.self, for: indexPath)
            cell.set(viewModel: itemViewModel)
            return cell
        }
        if let itemViewModel = itemViewModel as? ArticleImageTableViewCellViewModel {
            let cell = tableView.dequeueReusableCell(type: ArticleImageTableViewCell.self, for: indexPath)
            cell.set(viewModel: itemViewModel)
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - Privates

extension ArticleDetailViewController {
    func setupViews() {
        tableView.register(type: ArticleTitleTableViewCell.self)
        tableView.register(type: ArticleAggregateTableViewCell.self)
        tableView.register(type: ArticleSnippetTableViewCell.self)
        tableView.register(type: ArticleImageTableViewCell.self)
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
}
