//
//  ArticleSnippetTableViewCellViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

struct ArticleSnippetTableViewCellViewModel {
    let content: Content
}

// MARK: - ArticleSnippetTableViewCellProtocol

extension ArticleSnippetTableViewCellViewModel: ArticleSnippetTableViewCellProtocol {
    var snippet: String {
        return content.abstract ?? ""
    }
}
