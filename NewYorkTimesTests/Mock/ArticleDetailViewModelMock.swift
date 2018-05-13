//
//  ArticleDetailViewModelMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

@testable import NewYorkTimes

final class ArticleDetailViewModelMock {
    var mockedContent: Content!
    
    var index = 0
    var itemViewModels: [ArticleDetailItemViewModelProtocol] = []
    var itemViewModelAtIndex: ArticleDetailItemViewModelProtocol?
}

// MARK: - ArticleDetailViewModelProtocol

extension ArticleDetailViewModelMock: ArticleDetailViewModelProtocol {
    var content: Content {
        return mockedContent!
    }
    
    func itemViewModel(at index: Int) -> ArticleDetailItemViewModelProtocol? {
        return itemViewModelAtIndex
    }
}
