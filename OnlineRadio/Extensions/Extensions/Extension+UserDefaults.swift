//
//  Extension+UserDefaults.swift
//  DealApp
//
//  Created by Egor Sakhabaev on 27.04.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
extension UserDefaults {
    static func isFirstLaunch() -> Bool {
        let isFirstLaunchKey = "isFirstLaunch"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: isFirstLaunchKey)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: isFirstLaunchKey)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
