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
    
    var viewModel: ArticleDetailViewModelProtocol! {
        didSet {
            //tableView might hasn't loaded yet so treat it like an optional object
            tableView?.reloadData()
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
        if let itemViewModel = itemViewModel as? ArticleTitleTableViewCellProtocol {
            let cell = tableView.dequeueReusableCell(type: ArticleTitleTableViewCell.self, for: indexPath)
            cell.set(viewModel: itemViewModel)
            return cell
        }
        if let itemViewModel = itemViewModel as? ArticleAggregateTableViewCellProtocol {
            let cell = tableView.dequeueReusableCell(type: ArticleAggregateTableViewCell.self, for: indexPath)
            cell.set(viewModel: itemViewModel)
            return cell
        }
        if let itemViewModel = itemViewModel as? ArticleSnippetTableViewCellProtocol {
            let cell = tableView.dequeueReusableCell(type: ArticleSnippetTableViewCell.self, for: indexPath)
            cell.set(viewModel: itemViewModel)
            return cell
        }
        if let itemViewModel = itemViewModel as? ArticleImageTableViewCellProtocol {
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
