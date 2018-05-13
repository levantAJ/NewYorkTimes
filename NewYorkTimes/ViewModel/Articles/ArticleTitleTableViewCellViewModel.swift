//
//  ArticleTitleTableViewCellViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

final class ArticleTitleTableViewCellViewModel: ArticleDetailItemViewModelProtocol {
    let content: Content
    
    init(content: Content) {
        self.content = content
    }
}

extension ArticleTitleTableViewCellViewModel: ArticleTitleTableViewCellProtocol {
    var title: String {
        return content.title ?? ""
    }
}
