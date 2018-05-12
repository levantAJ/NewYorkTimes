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
    fileprivate var refreshControl: UIRefreshControl!
    fileprivate var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: ContentCollectionViewCell.self, for: indexPath)
        if let content = viewModel.content(at: indexPath.item) {
            cell.set(content: content)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 500)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            viewModel.loadMore()
        }
    }
}

// MARK: - Users Interactions

extension HomeViewController {
    func refreshControlValueChanged() {
        viewModel.refresh()
    }
}

// MARK: - Privates

extension HomeViewController {
    fileprivate func setupViews() {
        collectionView.register(type: ContentCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    fileprivate func setupViewModel() {
        viewModel = HomeViewModelFactory.create()
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
                    strongSelf.viewModel.append(content: content)
                    let indexPath = IndexPath(item: strongSelf.viewModel.numberOfRows - 1, section: 0)
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
