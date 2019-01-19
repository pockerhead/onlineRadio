//
//  Extension+TimeInterval.swift
//  Olimp
//
//  Created by Artem Balashov on 17/09/2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation

extension TimeInterval {
    var formattedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
    
//    var realTimeStamp: TimeInterval {
//        return self - AppSettings.timeShiftOffset
//    }
}
