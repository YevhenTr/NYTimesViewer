//
//  Functions.swift
//  Template
//
//  Created by Yevhen Triukhan on 31.07.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

public typealias Handler<T> = (T) -> ()
public typealias Completion<T> = (T) -> ()
public typealias Action<T> = (T) -> ()

public typealias EmptyAction = () -> ()

