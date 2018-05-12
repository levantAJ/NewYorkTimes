//
//  ContentServiceApiMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

@testable import NewYorkTimes

final class ContentServiceApiMock: ContentServiceApiProtocol {
    
    var pageIndex: UInt = 0
    var pageSize: UInt = 0
    var completion: ((Response<[Content]>) -> Void)?
 
    func request(pageIndex: UInt, pageSize: UInt, completion: @escaping (Response<[Content]>) -> Void) {
        self.pageSize = pageSize
        self.pageIndex = pageIndex
        self.completion = completion
    }
    
}
