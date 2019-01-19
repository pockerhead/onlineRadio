//
//  Extension+UILabel.swift
//  DealApp
//
//  Created by Egor Sakhabaev on 20.04.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import UIKit
extension UILabel{
    func updateSize() {
        let newFontSize = self.font.pointSize.dp
        let oldFontName = self.font.fontName
        self.font = UIFont(name: oldFontName, size: newFontSize)
    }
}
