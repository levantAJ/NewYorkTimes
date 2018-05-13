//
//  SearchArticlesResultsViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

final class SearchArticlesResultsViewModel {
    var onError: ((String) -> Void)?
    var onReloadData: (() -> Void)?
    fileprivate(set) var isLoading: Bool
    fileprivate(set) var currentPageIndex: UInt
    fileprivate var searchKeyword: String
    fileprivate let searchArticlesService: SearchArticlesServiceApiProtocol
    fileprivate let searchArticlesKeywordDatabase: SearchArticlesKeywordDatabaseApiProtocol
    fileprivate(set) var articleViewModels: [SearchArticlesResultsCollectionViewCellProtocol]
    fileprivate(set) var keywordViewModels: [SearchArticlesKeywordResultsCollectionViewCellProtocol]
    
    init(searchArticlesService: SearchArticlesServiceApiProtocol,
         searchArticlesKeywordDatabase: SearchArticlesKeywordDatabaseApiProtocol) {
        self.searchArticlesService = searchArticlesService
        self.searchArticlesKeywordDatabase = searchArticlesKeywordDatabase
        self.isLoading = false
        self.currentPageIndex = 0
        self.searchKeyword = ""
        self.articleViewModels = []
        self.keywordViewModels = []
    }
    
    func search(keyword: String) {
        searchKeyword = keyword
        request(pageIndex: 0)
    }
    
    func articleViewModel(at index: Int) -> SearchArticlesResultsCollectionViewCellProtocol? {
        if index >= 0 && index < articleViewModels.count {
            return articleViewModels[index]
        }
        return nil
    }
}

// MARK : - Pageable

extension SearchArticlesResultsViewModel: Pageable {
    func refresh() {
        request(pageIndex: 0)
    }
    
    func loadMore() {
        request(pageIndex: currentPageIndex + 1)
    }
}

// MARK : - Privates

extension SearchArticlesResultsViewModel {
    fileprivate func request(pageIndex: UInt) {
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
        }
    }
}
