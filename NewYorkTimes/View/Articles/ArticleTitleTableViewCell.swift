//
//  ArticleTitleTableViewCell.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

protocol ArticleTitleTableViewCellProtocol {
    var title: String { get }
}

final class ArticleTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func set(viewModel: ArticleTitleTableViewCellProtocol) {
        titleLabel.text = viewModel.title
    }
}
