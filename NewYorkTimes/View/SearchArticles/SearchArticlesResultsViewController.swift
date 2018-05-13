//
//  SearchArticlesResultsViewController.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

final class SearchArticlesResultsViewController: UIViewController {
    @IBOutlet weak var searchMessageLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var viewModel: SearchArticlesResultsViewModelProtocol!
    weak var searchBar: UISearchBar?
    fileprivate var heightCalculatingCell: SearchArticlesResultsCollectionViewCell!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - UISearchResultsUpdating

extension SearchArticlesResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        view.isHidden = false
    }
}

// MARK: - UISearchBarDelegate

extension SearchArticlesResultsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchMessageLabel.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        viewModel.search(keyword: keyword)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.retrieveRecentlyKeywords()
    }
}

// MARK: - UICollectionViewDataSource

extension SearchArticlesResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.articleViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let articleViewModel = viewModel.articleViewModel(at: indexPath.item)
        if let articleViewModel = articleViewModel as? SearchArticlesResultsCollectionViewCellProtocol {
            let cell = collectionView.dequeueReusableCell(type: SearchArticlesResultsCollectionViewCell.self, for: indexPath)
            cell.set(viewModel: articleViewModel)
            return cell
        }
        if let articleViewModel = articleViewModel as? SearchArticlesKeywordResultsCollectionViewCellProtocol {
            let cell = collectionView.dequeueReusableCell(type: SearchArticlesKeywordResultsCollectionViewCell.self, for: indexPath)
            cell.set(viewModel: articleViewModel)
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchArticlesResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize(at: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegate,

extension SearchArticlesResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let articleViewModel = viewModel.articleViewModel(at: indexPath.item) as? SearchArticlesKeywordResultsCollectionViewCellProtocol else { return }
        loadingView.startAnimating()
        searchBar?.text = articleViewModel.title
        searchBar?.resignFirstResponder()
        viewModel.search(keyword: articleViewModel.title)
    }
}

// MARK: - Privates

extension SearchArticlesResultsViewController {
    fileprivate func setupViews() {
        collectionView.register(type: SearchArticlesResultsCollectionViewCell.self)
        collectionView.register(type: SearchArticlesKeywordResultsCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    fileprivate func setupViewModel() {
        viewModel = SearchArticlesResultsViewModelFactory.create()
        viewModel.onError = { [weak self] errorMessage in
            guard let strongSelf = self else { return }
            strongSelf.searchMessageLabel.text = errorMessage
            strongSelf.searchMessageLabel.isHidden = false
        }
        viewModel.onReloadData = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.searchMessageLabel.isHidden = true
            strongSelf.collectionView.reloadData()
        }
        viewModel.onLoading = { [weak self] loadingStarted in
            guard let strongSelf = self else { return }
            if loadingStarted {
                strongSelf.loadingView.startAnimating()
            } else {
                strongSelf.loadingView.stopAnimating()
            }
        }
    }
    
    fileprivate func cellSize(at index: Int) -> CGSize {
        let width = view.bounds.width
        if let articleViewModel = viewModel.articleViewModel(at: index) as? SearchArticlesResultsCollectionViewCellProtocol {
            if let size = articleViewModel.cachedSize {
                return size
            }
            if heightCalculatingCell == nil {
                heightCalculatingCell = Bundle.main.loadNibNamed(String(describing: SearchArticlesResultsCollectionViewCell.self), owner: nil)!.first as! SearchArticlesResultsCollectionViewCell
                heightCalculatingCell.frame = CGRect(x: 0, y: 0, width: width, height: 100)
            }
            let size = CGSize(width: width, height: heightCalculatingCell.height(for: articleViewModel))
            articleViewModel.cachedSize = size //Cache size to improve scrolling
            return size
        }
        return CGSize(width: width, height: 44)
    }
}
