//
//  HomeViewController.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var viewModel: HomeViewModelProtocol!
    fileprivate var refreshControl: UIRefreshControl!
    fileprivate var searchArticlesVC: SearchArticlesResultsViewController!
    fileprivate var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.HomeViewController.ToArticlesIdentifier {
            let articlesVC = segue.destination as! ArticlesViewController
            let index = sender as! Int
            let contents = viewModel.contentViewModels.map { $0.content }
            articlesVC.viewModel = ArticlesViewModel(contents: contents, currentIndex: index)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.contentViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: ContentCollectionViewCell.self, for: indexPath)
        if let content = viewModel.contentViewModel(at: indexPath.item) {
            cell.set(viewModel: content)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 500)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            viewModel.loadMore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constant.HomeViewController.ToArticlesIdentifier, sender: indexPath.item)
    }
}

// MARK: - Users Interactions

extension HomeViewController {
    @objc func refreshControlValueChanged() {
        viewModel.refresh()
    }
}

// MARK: - Privates

extension HomeViewController {
    fileprivate func setupViews() {
        title = NSLocalizedString("The New York Times", comment: "")
        
        collectionView.register(type: ContentCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        searchArticlesVC = UIStoryboard.viewController(screenName: String(describing: SearchArticlesResultsViewController.self), storyboardName: "SearchArticles") as! SearchArticlesResultsViewController
        searchController = UISearchController(searchResultsController: searchArticlesVC)
        searchController.searchResultsUpdater = searchArticlesVC
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search Articles", comment: "")
        searchController.searchBar.delegate = searchArticlesVC
        searchArticlesVC.searchBar = searchController.searchBar
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    fileprivate func setupViewModel() {
        viewModel.onReloadData = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.refreshControl.endRefreshing()
            strongSelf.loadingView.stopAnimating()
            strongSelf.collectionView.reloadData()
        }
        viewModel.onMoreData = { [weak self] contents in
            guard let strongSelf = self else { return }
            strongSelf.collectionView.performBatchUpdates({
                for content in contents {
                    strongSelf.viewModel.append(contentViewModel: content)
                    let indexPath = IndexPath(item: strongSelf.viewModel.contentViewModels.count - 1, section: 0)
                    strongSelf.collectionView.insertItems(at: [indexPath])
                }
            })
        }
        viewModel.onError = { [weak self] errorMessage in
            guard let strongSelf = self else { return }
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: errorMessage, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            strongSelf.present(alertController, animated: true, completion: nil)
        }
        viewModel.refresh()
    }
}

extension Constant {
    struct HomeViewController {
        static let ToArticlesIdentifier = "ToArticles"
    }
}
