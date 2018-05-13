//
//  ArticleSnippetTableViewCell.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

protocol ArticleSnippetTableViewCellProtocol: ArticleDetailItemViewModelProtocol {
    var snippet: String { get }
}

final class ArticleSnippetTableViewCell: UITableViewCell {
    @IBOutlet weak var snippetLabel: UILabel!
    
    func set(viewModel: ArticleSnippetTableViewCellProtocol) {
        snippetLabel.text = viewModel.snippet
    }
}
