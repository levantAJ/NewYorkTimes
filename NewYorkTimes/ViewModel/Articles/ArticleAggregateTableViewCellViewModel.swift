//
//  ArticleAggregateTableViewCellViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

final class ArticleAggregateTableViewCellViewModel: ArticleDetailItemViewModelProtocol {
    let content: Content
    
    init(content: Content) {
        self.content = content
    }
}

// MARK: - ArticleAggregateTableViewCellProtocol

extension ArticleAggregateTableViewCellViewModel: ArticleAggregateTableViewCellProtocol {
    var date: String {
        return content.date?.dateString ?? ""
    }
    
    var byline: String {
        return content.byline ?? ""
    }
    
    var source: String {
        return content.source ?? ""
    }
}

