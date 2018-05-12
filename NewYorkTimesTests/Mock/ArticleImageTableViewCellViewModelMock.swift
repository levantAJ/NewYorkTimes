//
//  ArticleImageTableViewCellViewModelMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit
@testable import NewYorkTimes

final class ArticleImageTableViewCellViewModelMock {
    var completion: ((String, Response<(UIImage)>) -> Void)?
    var caption = "caption"
    var id = "id"
}

// MARK: - ArticleImageTableViewCellProtocol

extension ArticleImageTableViewCellViewModelMock: ArticleImageTableViewCellProtocol {
    func loadImage(completion: @escaping (String, Response<(UIImage)>) -> Void) {
        self.completion = completion
    }
}
