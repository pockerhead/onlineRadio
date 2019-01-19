//
//  CGFloat + Convert.swift
//  Olimp
//
//  Created by Artem Balashov on 12/12/2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGFloat {
    func convert(_ distance1: Distance, to distance2: Distance) -> CGFloat {
        let xPercentage = self / (distance1.x1 - distance1.x0)
        return distance2.x0 + (xPercentage * (distance2.x1 - distance2.x0))
    }
}

struct Distance {
    var x0: CGFloat
    var x1: CGFloat
}
