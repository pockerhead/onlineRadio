//
//  Extension+Array.swift
//  Olimp
//
//  Created by Egor Sakhabaev on 24.07.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}
