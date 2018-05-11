//
//  AppConstant.swift
//  NewYorkTimes
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

public struct Constant {}

public enum Response<Value> {
    case success(Value)
    case failure(Error)
}
