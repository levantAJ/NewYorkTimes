//
//  SearchArticlesKeywordResultsCollectionViewCell.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

protocol SearchArticlesKeywordResultsCollectionViewCellProtocol: SearchArticlesResultsCellViewModelProtocol {
    var title: String { get }
}

final class SearchArticlesKeywordResultsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func set(viewModel: SearchArticlesKeywordResultsCollectionViewCellProtocol) {
        titleLabel.text = viewModel.title
    }
}
