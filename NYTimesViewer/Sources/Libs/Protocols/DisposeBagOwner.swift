//
//  DisposeBagOwner.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

#if canImport(RxSwift)

import RxSwift

fileprivate var disposeBagKey = "disposeBag.disposeBagOwner.key"

public protocol DisposeBagOwner {
    var dispose: DisposeBag { get }
}

extension NSObject: DisposeBagOwner{
    
    open var dispose:DisposeBag {
        get {
            if let value = objc_getAssociatedObject(self, &disposeBagKey) as? DisposeBag {
                return value
            } else {
                let bag = DisposeBag.init()
                objc_setAssociatedObject(self, &disposeBagKey, bag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return bag
            }
        }
    }
}

extension Disposable {
    
    func disposed(by bagOwner: DisposeBagOwner) {
        disposed(by: bagOwner.dispose)
    }
}

#endif
