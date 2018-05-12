//
//  ArticlesViewModelMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

@testable import NewYorkTimes

final class ArticlesViewModelMock {
    var currentIndex: Int = 0
    var detailViewModels: [ArticleDetailViewModel] = []
    var detailViewModelAtIndex: ArticleDetailViewModel?
}

// MARK: - ArticlesViewModelProtocol

extension ArticlesViewModelMock: ArticlesViewModelProtocol {
    func detailViewModel(at index: Int) -> ArticleDetailViewModel? {
        return detailViewModelAtIndex
    }
}
