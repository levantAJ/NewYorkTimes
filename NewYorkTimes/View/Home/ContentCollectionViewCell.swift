//
//  ContentCollectionViewCell.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

protocol ContentCollectionViewCellProtocol: ImageLoadable {
    var title: String { get }
    var date: String { get }
    var snippet: String { get }
}

final class ContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var snippetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    fileprivate var viewModel: ContentCollectionViewCellProtocol?

    func set(viewModel: ContentCollectionViewCellProtocol) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        snippetLabel.text = viewModel.snippet
        dateLabel.text = viewModel.date
        imageView.image = nil
        viewModel.loadImage { [weak self] (id, response) in
            guard let strongSelf = self,
                strongSelf.viewModel?.id == id else { return }
            switch response {
            case .success(let image):
                strongSelf.imageView.image = image;
            case .failure(let error):
                //TODO: Handle to show error here
                debugPrint(error.localizedDescription)
            }
        }
    }
}
