//
//  ArticleSnippetTableViewCellViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

final class ArticleSnippetTableViewCellViewModel {
    let content: Content
    
    init(content: Content) {
        self.content = content
    }
}

// MARK: - ArticleSnippetTableViewCellProtocol

extension ArticleSnippetTableViewCellViewModel: ArticleSnippetTableViewCellProtocol {
    var snippet: String {
        return content.abstract ?? ""
    }
}
