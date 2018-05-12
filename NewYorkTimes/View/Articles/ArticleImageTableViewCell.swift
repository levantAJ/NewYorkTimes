//
//  ArticleImageTableViewCell.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

protocol ArticleImageTableViewCellProtocol: ImageLoadable {
    var caption: String { get }
}

final class ArticleImageTableViewCell: UITableViewCell {
    @IBOutlet weak var multimediaImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    fileprivate var viewModel: ArticleImageTableViewCellProtocol!
    
    func set(viewModel: ArticleImageTableViewCellProtocol) {
        self.viewModel = viewModel
        captionLabel.text = viewModel.caption
        multimediaImageView.image = nil
        viewModel.loadImage { [weak self] (id, response) in
            guard let strongSelf = self,
                strongSelf.viewModel?.id == id else { return }
            switch response {
            case .success(let image):
                strongSelf.multimediaImageView.image = image;
            case .failure(let error):
                //TODO: Handle to show error here
                debugPrint(error.localizedDescription)
            }
        }
    }
}
