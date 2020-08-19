//
//  Array+Extensions.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

extension Array {
    
    func object(at index: Int) -> Element? {
        return index < self.count ? self[index] : nil
    }
}
