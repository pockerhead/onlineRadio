////
////  Extension + SideMenuController.swift
////  Olimp
////
////  Created by Artem Balashov on 17/01/2019.
////  Copyright © 2019 Egor Sakhabaev. All rights reserved.
////
//
//import Foundation
//import SideMenuSwift
//
//extension SideMenuController {
//    static func getConfiguredSideMenu() -> SideMenuController {
//        let liveMatchesViewController = LiveMatchesConfigurator.createModule()
//        let liveChatViewController = LivechatConfigurator.createModule()
//        let menuViewController = SideMenuConfigurator.createModule()
//        let sideMenuController = SideMenuController(contentViewController: liveMatchesViewController, menuViewController: menuViewController)
//        sideMenuController.cache(viewController: liveChatViewController, with: CachedVCs.liveChat.rawValue)
//        SideMenuController.preferences.basic.menuWidth = CGFloat(310.0).dp
//        SideMenuController.preferences.basic.statusBarBehavior = .none
//        SideMenuController.preferences.basic.position = .above
//        SideMenuController.preferences.basic.direction = .left
//        SideMenuController.preferences.basic.enablePanGesture = true
//        SideMenuController.preferences.basic.supportedOrientations = .portrait
//        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
//        return sideMenuController
//    }
//}
