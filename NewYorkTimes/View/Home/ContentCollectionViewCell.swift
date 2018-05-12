//
//  ContentCollectionViewCell.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

protocol ContentCollectionViewCellProtocol {
    var id: String { get }
    var title: String { get }
    var date: String { get }
    var snippet: String { get }
    func loadImage(completion: (String, UIImage?) -> Void)
}

final class ContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var snippetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    fileprivate var content: ContentCollectionViewCellProtocol?

    func set(content: ContentCollectionViewCellProtocol) {
        self.content = content
        titleLabel.text = content.title
        snippetLabel.text = content.snippet
        dateLabel.text = content.date
        content.loadImage { [weak self] (id, image) in
            guard let strongSelf = self,
                strongSelf.content?.id == id else { return }
            strongSelf.imageView.image = image;
        }
    }
}
