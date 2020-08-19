//
//  Dictionary+Extensions.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

extension Dictionary {

    var allKeys: [Key] { Array(self.keys) }
    
    var allValues: [Value] { Array(self.values) }
    
    @discardableResult
    func append(_ value: Dictionary.Value, forKey key: Dictionary.Key) -> Dictionary<Dictionary.Key, Dictionary.Value> {
        var tmp = self
        
        tmp.updateValue(value, forKey: key)
        
        return tmp
    }
    
    @discardableResult
    func append(_ dictionary: [Dictionary.Key: Dictionary.Value]) -> Dictionary<Dictionary.Key, Dictionary.Value> {
        var tmp = self
        
        dictionary.forEach { (key, value) in
            tmp = tmp.append(value, forKey: key)
        }
        
        return tmp
    }
    
    func toJSON() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch {
            print(error)
        }
        
        return nil
    }
}
