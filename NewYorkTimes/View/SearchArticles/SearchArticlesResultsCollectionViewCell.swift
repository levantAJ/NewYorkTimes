//
//  SearchArticlesResultsCollectionViewCell.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

protocol SearchArticlesResultsCollectionViewCellProtocol: SearchArticlesResultsCellViewModelProtocol {
    var title: String { get }
    var snippet: String { get }
    var cachedSize: CGSize? { get set } //Cache size to improve scrolling
}

final class SearchArticlesResultsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var snippetLabel: UILabel!
    
    func set(viewModel: SearchArticlesResultsCollectionViewCellProtocol) {
        titleLabel.text = viewModel.title
        snippetLabel.text = viewModel.snippet
    }
    
    func height(for viewModel: SearchArticlesResultsCollectionViewCellProtocol) -> CGFloat {
        let titleHeight = viewModel.title.height(constrainedWidth: frame.width - titleLabel.frame.minX * 2, font: titleLabel.font)
        let snippetHeight = viewModel.snippet.height(constrainedWidth: frame.width - snippetLabel.frame.minX * 2, font: snippetLabel.font)
        return titleHeight + snippetHeight + titleLabel.frame.minY * 2 + 4 //Spacing
    }
}
