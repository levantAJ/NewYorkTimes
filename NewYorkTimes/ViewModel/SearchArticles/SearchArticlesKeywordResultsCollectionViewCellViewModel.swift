//
//  SearchArticlesKeywordResultsCollectionViewCellViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

final class SearchArticlesKeywordResultsCollectionViewCellViewModel {
    let keyword: String
    
    init(keyword: String) {
        self.keyword = keyword
    }
}

// MARK: - SearchArticlesKeywordResultsCollectionViewCellProtocol

extension SearchArticlesKeywordResultsCollectionViewCellViewModel: SearchArticlesKeywordResultsCollectionViewCellProtocol {
    var title: String {
        return keyword
    }
}
