//
//  ArticleTitleTableViewCellViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

struct ArticleTitleTableViewCellViewModel {
    let content: Content
}

extension ArticleTitleTableViewCellViewModel: ArticleTitleTableViewCellProtocol {
    var title: String {
        return content.title ?? ""
    }
}
