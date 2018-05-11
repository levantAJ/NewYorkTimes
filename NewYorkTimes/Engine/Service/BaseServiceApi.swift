//
//  BaseServiceApi.swift
//  NewYorkTimes
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum API {
    case getNews(pageIndex: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getNews:
            return .get
        }
    }
    
    var url: String {
        return Constant.BaseServiceApi.Host + path + "api-key=" + Constant.BaseServiceApi.NewYorkTimesKey
    }
    
    private var path: String {
        switch self {
        case .getNews(let pageIndex):
            return "/svc/search/v2/articlesearch.json?page=\(pageIndex)&"
        }
    }
}

extension Constant {
    struct BaseServiceApi {
        static let NewYorkTimesKey = "180e7895aa4045f5bdf78389e0cd3ec2"
        static let Host = "https://api.nytimes.com"
        
    }
}
