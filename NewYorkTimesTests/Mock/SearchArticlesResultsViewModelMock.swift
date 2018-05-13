//
//  SearchArticlesResultsViewModelMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

@testable import NewYorkTimes

final class SearchArticlesResultsViewModelMock {
    var searchKeyword: String?
    var didCallRetrieveRecentlyKeywords = false
    
    var onLoading: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var onReloadData: (() -> Void)?
    var articleViewModels: [SearchArticlesResultsCellViewModelProtocol] = []
    var articleViewModelAtIndex: SearchArticlesResultsCellViewModelProtocol?
}

// MARK: - SearchArticlesResultsViewModelProtocol

extension SearchArticlesResultsViewModelMock: SearchArticlesResultsViewModelProtocol {
    func search(keyword: String) {
        self.searchKeyword = keyword
    }
    
    func retrieveRecentlyKeywords() {
        didCallRetrieveRecentlyKeywords = true
    }
    
    func articleViewModel(at index: Int) -> SearchArticlesResultsCellViewModelProtocol? {
        return articleViewModelAtIndex
    }
}
