//
//  SearchArticlesResultsViewModelFactory.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

extension UserDefaults: UserDefaultsProtocol {}

final class SearchArticlesResultsViewModelFactory {
    static func create() -> SearchArticlesResultsViewModel {
        let session = URLSession.shared
        let request = RequestService(session: session)
        let searchArticlesService = SearchArticlesServiceApi(request: request)
        let userDefaults = UserDefaults.standard
        let searchArticlesKeywordDatabase = SearchArticlesKeywordDatabaseApi(userDefaults: userDefaults)
        return SearchArticlesResultsViewModel(searchArticlesService: searchArticlesService, searchArticlesKeywordDatabase: searchArticlesKeywordDatabase)
    }
}
