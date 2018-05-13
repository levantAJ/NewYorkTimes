//
//  ArticleDetailViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

protocol ArticleDetailItemViewModelProtocol {}

protocol ArticleDetailViewModelProtocol {
    var index: Int { get }
    var content: Content { get }
    var itemViewModels: [ArticleDetailItemViewModelProtocol] { get }
    func itemViewModel(at index: Int) -> ArticleDetailItemViewModelProtocol?
}

final class ArticleDetailViewModel {
    let index: Int
    let content: Content
    let itemViewModels: [ArticleDetailItemViewModelProtocol]
    let downloadImageService: DownloadImageService
    
    init(content: Content, index: Int) {
        self.content = content
        self.index = index
        self.downloadImageService = DownloadImageService(session: URLSession.shared)
        var viewModels: [ArticleDetailItemViewModelProtocol] = [
            ArticleTitleTableViewCellViewModel(content: content),
            ArticleAggregateTableViewCellViewModel(content: content),
            ArticleSnippetTableViewCellViewModel(content: content),
            ]
        if let multimedia = content.multimedias?.last {
            viewModels.append(ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: self.downloadImageService))
        }
        itemViewModels = viewModels
    }
}

// MARK: - ArticleDetailViewModelProtocol

extension ArticleDetailViewModel: ArticleDetailViewModelProtocol {
    func itemViewModel(at index: Int) -> ArticleDetailItemViewModelProtocol? {
        if index < itemViewModels.count {
            return itemViewModels[index]
        }
        return nil
    }
}
