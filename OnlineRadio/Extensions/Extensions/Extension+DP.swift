//
//  Extension+CGFloat.swift
//  DealApp
//
//  Created by Egor Sakhabaev on 20.04.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import UIKit
extension CGFloat {
    var dp: CGFloat {
        return (self / 375) * UIScreen.main.bounds.width //375 because our design for iPhone 6
    }
}
extension Float {
    var dp: Float {
        return (self / 375) * Float(UIScreen.main.bounds.width) //375 because our design for iPhone 6
    }
}
extension Double {
    var dp: Double {
        return (self / 375) * Double(UIScreen.main.bounds.width) //375 because our design for iPhone 6
    }
}
