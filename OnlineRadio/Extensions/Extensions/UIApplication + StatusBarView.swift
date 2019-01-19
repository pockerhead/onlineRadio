//
//  UIApplication + StatusBarView.swift
//  Olimp
//
//  Created by Artem Balashov on 05/12/2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector("statusBar")) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
