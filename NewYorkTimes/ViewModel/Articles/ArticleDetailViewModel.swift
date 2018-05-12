//
//  ArticleDetailViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

struct ArticleDetailViewModel {
    let index: Int
    let content: Content
    let itemViewModels: [Any]
    
    init(content: Content, index: Int) {
        self.content = content
        self.index = index
        itemViewModels = [
            ArticleTitleTableViewCellViewModel(content: content)
        ]
    }
    
    func itemViewModel(at index: Int) -> Any? {
        if index < itemViewModels.count {
            return itemViewModels[index]
        }
        return nil
    }
}
