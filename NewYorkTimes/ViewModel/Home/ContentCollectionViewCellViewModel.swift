//
//  ContentCollectionViewCellViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit
import Foundation

struct ContentCollectionViewCellViewModel {
    let content: Content
}

// MARK: - ContentCollectionViewCellProtocol

extension ContentCollectionViewCellViewModel: ContentCollectionViewCellProtocol {
    var id: String {
        return content.url?.absoluteString ?? ""
    }
    
    var title: String {
        return content.title ?? ""
    }
    
    var date: String {
        return content.date?.dateString ?? ""
    }
    
    var snippet: String {
        return content.abstract ?? ""
    }
   
    func loadImage(completion: (String, UIImage?) -> Void) {
        
    }
}
