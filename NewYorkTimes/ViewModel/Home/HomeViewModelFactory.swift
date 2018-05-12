//
//  HomeViewModelFactory.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

final class HomeViewModelFactory {
    static func create() -> HomeViewModel {
        let session = URLSession.shared
        let request = RequestService(session: session)
        let contentSerivce = ContentServiceApi(request: request)
        return HomeViewModel(contentSerivce: contentSerivce)
    }
}
