//
//  SearchArticlesResultsCollectionViewCellViewModelMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import CoreGraphics
@testable import NewYorkTimes

final class SearchArticlesResultsCollectionViewCellViewModelMock: SearchArticlesResultsCollectionViewCellProtocol {
    var title = "title"
    var snippet = "snippet"
    var cachedSize: CGSize?
}
