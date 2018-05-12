//
//  ContentCollectionViewCellViewModelMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit
@testable import NewYorkTimes

final class ContentCollectionViewCellViewModelMock {
    var completion: ((String, Response<(UIImage)>) -> Void)?
    var title = "title"
    var date = "date"
    var snippet = "snippet"
    var id = "id"
}

// MARK: - ContentCollectionViewCellProtocol

extension ContentCollectionViewCellViewModelMock: ContentCollectionViewCellProtocol {
    func loadImage(completion: @escaping (String, Response<(UIImage)>) -> Void) {
        self.completion = completion
    }
}
