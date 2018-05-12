//
//  ArticlesViewController.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

final class ArticlesViewController: UIViewController {
    var viewModel: ArticlesViewModelProtocol!
    
    fileprivate var pageVC: UIPageViewController!
    fileprivate var leftVC: ArticleDetailViewController!
    fileprivate var rightVC: ArticleDetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - UIPageViewControllerDataSource

extension ArticlesViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = (viewController as! ArticleDetailViewController).viewModel?.index,
            currentIndex > 0,
            let detailViewModel = viewModel.detailViewModel(at: currentIndex - 1) else { return nil }
        
        if viewController == leftVC {
            rightVC.viewModel = detailViewModel
            return rightVC
        }
        leftVC.viewModel = detailViewModel
        return leftVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = (viewController as! ArticleDetailViewController).viewModel?.index,
        currentIndex < viewModel.detailViewModels.count - 1,
        let detailViewModel = viewModel.detailViewModel(at: currentIndex + 1) else { return nil }
        
        if viewController == rightVC {
            leftVC.viewModel = detailViewModel
            return leftVC
        }
        rightVC.viewModel = detailViewModel
        return rightVC
    }
}

// MARK: - Privates

extension ArticlesViewController {
    fileprivate func setupViews() {
        pageVC = UIStoryboard.viewController(screenName: "ArticlesPageViewController", storyboardName: "Articles") as! UIPageViewController
        leftVC = UIStoryboard.viewController(screenName: "ArticleDetailViewController", storyboardName: "Articles") as! ArticleDetailViewController
        leftVC.viewModel = viewModel.detailViewModel(at: viewModel.currentIndex)
        rightVC = UIStoryboard.viewController(screenName: "ArticleDetailViewController", storyboardName: "Articles") as! ArticleDetailViewController
        pageVC.setViewControllers([leftVC], direction: .forward, animated: true, completion: nil)
        pageVC.dataSource = self
        view.addSubview(pageVC.view)
        addChildViewController(pageVC)
        pageVC.didMove(toParentViewController: self)
    }
}
