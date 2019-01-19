//
//  Extension+Float.swift
//  Olimp
//
//  Created by Egor Sakhabaev on 08.08.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
extension Formatter {
    static let number = NumberFormatter()
}

//extension FloatingPoint {
//    func fractionDigits(min: Int = 0, max: Int = UserManager.currentUser?.decimalsCount ?? 2, roundingMode: NumberFormatter.RoundingMode = .halfUp, shouldAddSymbol: Bool = false) -> String {
//        Formatter.number.minimumFractionDigits = min
//        Formatter.number.maximumFractionDigits = max
//        Formatter.number.roundingMode = roundingMode
//        Formatter.number.numberStyle = .decimal
//        Formatter.number.groupingSeparator = " "
//        Formatter.number.decimalSeparator = "."
//        var formattedString = Formatter.number.string(for: self) ?? ""
//        if shouldAddSymbol, let currencySymbol = UserManager.currentUser?.currency.symbol {
//            formattedString += " \(currencySymbol)"
//        }
//        return formattedString
//    }
//}

extension String {
    func doubleValue() -> Double {
        return Formatter.number.number(from: self)?.doubleValue ?? 0.0
    }
}
