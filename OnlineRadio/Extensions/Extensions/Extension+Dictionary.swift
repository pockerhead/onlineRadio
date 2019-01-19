//
//  Extension+Dictionary.swift
//  Olimp
//
//  Created by Egor Sakhabaev on 20.07.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
extension Dictionary {
    public static func +=(lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach{ lhs[$0] = $1}
    }
    
    public func without(key: Key) -> [Key: Value] {
        var temp = self
        temp.removeValue(forKey: key)
        return temp
    }
    
    public func without(keys: [Key]) -> [Key: Value] {
        var temp = self
        keys.forEach { (key) in
            temp.removeValue(forKey: key)
        }
        return temp
    }
}


