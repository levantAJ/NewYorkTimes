//
//  ArticleAggregateTableViewCell.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

protocol ArticleAggregateTableViewCellProtocol: ArticleDetailItemViewModelProtocol {
    var date: String { get }
    var byline: String { get }
    var source: String { get }
}

final class ArticleAggregateTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    func set(viewModel: ArticleAggregateTableViewCellProtocol) {
        dateLabel.text = viewModel.date
        bylineLabel.text = viewModel.byline
        sourceLabel.text = viewModel.source
    }
}
