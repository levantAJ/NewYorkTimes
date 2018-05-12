//
//  API.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum API {
    case getContents(pageIndex: UInt, pageSize: UInt)
    case searchArticles(query: String, pageIndex: UInt)
    
    var method: HTTPMethod {
        switch self {
        case .searchArticles,
             .getContents:
            return .get
        }
    }
    
    var url: URL {
        var component = URLComponents()
        component.scheme = Constant.BaseServiceApi.Scheme
        component.host = Constant.BaseServiceApi.Host
        component.path = path
        component.queryItems = queryItems + [URLQueryItem(name: "api-key", value: Constant.BaseServiceApi.NewYorkTimesKey)]
        return component.url! //Force unwrapping to make sure URL never nil
    }
}

// MARK: - Privates

extension API {
    fileprivate var path: String {
        switch self {
        case .getContents:
            return "/svc/news/v3/content/all/all.json"
        case .searchArticles:
            return "/svc/search/v2/articlesearch.json"
        }
    }
    
    fileprivate var queryItems: [URLQueryItem] {
        switch self {
        case .getContents(let pageIndex, let pageSize):
            return [URLQueryItem(name: "limit", value: "\(pageSize)"), URLQueryItem(name: "offset", value: "\(pageIndex)")]
        case .searchArticles(let query, let pageIndex):
            return [URLQueryItem(name: "q", value: query), URLQueryItem(name: "page", value: "\(pageIndex)")]
        }
    }
}
