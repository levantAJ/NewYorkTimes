//
//  SearchArticlesResultsCollectionViewCellViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import CoreGraphics

final class SearchArticlesResultsCollectionViewCellViewModel {
    let article: Article
    var cachedSize: CGSize?
    
    init(article: Article) {
        self.article = article
    }
}

// MARK: - SearchArticlesResultsCollectionViewCellProtocol

extension SearchArticlesResultsCollectionViewCellViewModel: SearchArticlesResultsCollectionViewCellProtocol {
    var title: String {
        return article.title ?? ""
    }
    
    var snippet: String {
        return article.snippet ?? ""
    }
}
