//
//  ArticleDetailViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

struct ArticleDetailViewModel {
    let index: Int
    let content: Content
    let itemViewModels: [Any]
    fileprivate let downloadImageService: DownloadImageService
    
    init(content: Content, index: Int) {
        self.content = content
        self.index = index
        self.downloadImageService = DownloadImageService(session: URLSession.shared)
        var viewModels: [Any] = [
            ArticleTitleTableViewCellViewModel(content: content),
            ArticleAggregateTableViewCellViewModel(content: content),
            ArticleSnippetTableViewCellViewModel(content: content),
            ]
        for multimedia in content.multimedias ?? [] {
            viewModels.append(ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: self.downloadImageService))
        }
        itemViewModels = viewModels
    }
    
    func itemViewModel(at index: Int) -> Any? {
        if index < itemViewModels.count {
            return itemViewModels[index]
        }
        return nil
    }
}
