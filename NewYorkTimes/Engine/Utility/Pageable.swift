//
//  Pageable.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

protocol Pageable {
    var isLoading: Bool { get }
    var currentPageIndex: UInt { get }
    func refresh()
    func loadMore()
}
