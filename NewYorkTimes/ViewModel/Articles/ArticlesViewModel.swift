//
//  ArticlesViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

protocol ArticlesViewModelProtocol {
    var currentIndex: Int { get }
    var detailViewModels: [ArticleDetailViewModel] { get }
    func detailViewModel(at index: Int) -> ArticleDetailViewModel?
}

final class ArticlesViewModel {
    let currentIndex: Int
    let detailViewModels: [ArticleDetailViewModel]
    
    init(contents: [Content], currentIndex: Int) {
        self.currentIndex = currentIndex
        var viewModels: [ArticleDetailViewModel] = []
        for (index, content) in contents.enumerated() {
            let detailViewModel = ArticleDetailViewModel(content: content, index: index)
            viewModels.append(detailViewModel)
        }
        self.detailViewModels = viewModels
    }
}

// MARK: - ArticlesViewModelProtocol

extension ArticlesViewModel: ArticlesViewModelProtocol {
    func detailViewModel(at index: Int) -> ArticleDetailViewModel? {
        if index < detailViewModels.count && index >= 0 {
            return detailViewModels[index]
        }
        return nil
    }
}
