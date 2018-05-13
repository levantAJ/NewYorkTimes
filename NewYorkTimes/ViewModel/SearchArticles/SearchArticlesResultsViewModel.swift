//
//  SearchArticlesResultsViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

protocol SearchArticlesResultsCellViewModelProtocol: class {}

protocol SearchArticlesResultsViewModelProtocol {
    var onLoading: ((Bool) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    var onReloadData: (() -> Void)? { get set }
    var articleViewModels: [SearchArticlesResultsCellViewModelProtocol] { get }
    func search(keyword: String)
    func retrieveRecentlyKeywords()
    func articleViewModel(at index: Int) -> SearchArticlesResultsCellViewModelProtocol?
}

final class SearchArticlesResultsViewModel {
    var onLoading: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var onReloadData: (() -> Void)?
    fileprivate let searchArticlesService: SearchArticlesServiceApiProtocol
    fileprivate let searchArticlesKeywordDatabase: SearchArticlesKeywordDatabaseApiProtocol
    fileprivate(set) var isLoading: Bool
    fileprivate(set) var currentPageIndex: UInt
    fileprivate(set) var searchKeyword: String
    fileprivate(set) var articleViewModels: [SearchArticlesResultsCellViewModelProtocol]
    
    init(searchArticlesService: SearchArticlesServiceApiProtocol,
         searchArticlesKeywordDatabase: SearchArticlesKeywordDatabaseApiProtocol) {
        self.searchArticlesService = searchArticlesService
        self.searchArticlesKeywordDatabase = searchArticlesKeywordDatabase
        self.isLoading = false
        self.currentPageIndex = 0
        self.searchKeyword = ""
        self.articleViewModels = []
    }
}

// MARK: - SearchArticlesResultsViewModelProtocol

extension SearchArticlesResultsViewModel: SearchArticlesResultsViewModelProtocol {
    func search(keyword: String) {
        searchKeyword = keyword
        onLoading?(true)
        articleViewModels = []
        onReloadData?()
        searchArticlesKeywordDatabase.add(keyword: keyword, completion: nil)
        retrieveArticles(pageIndex: 0)
    }
    
    func retrieveRecentlyKeywords() {
        searchArticlesKeywordDatabase.request(pageIndex: 0, pageSize: 10) { [weak self] response in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let keywords):
                strongSelf.articleViewModels = keywords.map { SearchArticlesKeywordResultsCollectionViewCellViewModel(keyword: $0) }
                strongSelf.onReloadData?()
            case .failure(let error):
                strongSelf.onError?(error.localizedDescription)
            }
        }
    }
    
    func articleViewModel(at index: Int) -> SearchArticlesResultsCellViewModelProtocol? {
        if index >= 0 && index < articleViewModels.count {
            return articleViewModels[index]
        }
        return nil
    }
}

// MARK: - Pageable

extension SearchArticlesResultsViewModel: Pageable {
    func refresh() {
        retrieveArticles(pageIndex: 0)
    }
    
    func loadMore() {
        retrieveArticles(pageIndex: currentPageIndex + 1)
    }
}

// MARK: - Privates

extension SearchArticlesResultsViewModel {
    fileprivate func retrieveArticles(pageIndex: UInt) {
        guard !isLoading else { return } //Avoid making multiple requests a the same time.
        isLoading = true
        currentPageIndex = pageIndex
        searchArticlesService.search(query: searchKeyword, pageIndex: pageIndex) { [weak self] response in
            guard let strongSelf = self else { return }
            strongSelf.isLoading = false
            switch response {
            case .success(let articles):
                if articles.isEmpty {
                    strongSelf.articleViewModels = []
                    DispatchQueue.main.async {
                        strongSelf.onError?(NSLocalizedString("No Results", comment: ""))
                    }
                } else {
                    strongSelf.articleViewModels = articles.map { SearchArticlesResultsCollectionViewCellViewModel(article: $0) }
                    DispatchQueue.main.async {
                        strongSelf.onReloadData?()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    strongSelf.onError?(error.localizedDescription)
                }
            }
            DispatchQueue.main.async {
                strongSelf.onLoading?(false)
            }
        }
    }
}
