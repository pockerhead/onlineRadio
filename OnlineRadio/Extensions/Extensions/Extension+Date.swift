//  DealApp
//
//  Created by Egor Sakhabaev on 11.04.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//
import UIKit

extension Date {
    
    func stringFromDate(format: String? = "dd.MM.yy") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        let resultString = dateFormatter.string(from: self)
        
        return resultString
    }
    
    func dateFromDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        let resultString = dateFormatter.string(from: self)
        
        return resultString
    }
    
    func monthFromDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = Locale(identifier: "ru")
        
        let resultString = dateFormatter.string(from: self)
        
        return resultString
    }
    
    func startOfMonth() -> Date {
        let a = Calendar.current.startOfDay(for: self)
        let b = Calendar.current.dateComponents([.year, .month], from: a)
        return Calendar.current.date(from: b)!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}

extension String {
    
    func dateFromString(format: String? = "dd.MM.yy") -> Date? {
        guard format != nil else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        let resultDate = dateFormatter.date(from: self)
        return resultDate
    }
    
    static func estimageTextSize(text: String?, size: CGSize = CGSize(width: 200, height: 1000), font: UIFont = UIFont.systemFont(ofSize: 14)) -> CGRect? {
        
        guard let text = text else { return nil }
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: options, attributes:
            [NSAttributedString.Key.font: font], context: nil)
        
        return estimatedFrame
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the amount of nanoseconds from another date
    func nanoseconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }
}

//extension Int {
//    func dayString() -> String {
//        let lastDigit = self % 10
//        if (self >= 11 && self <= 19)
//        {
//            return "dateExtension.days".localized;
//        }
//        else
//        {
//            if lastDigit == 1 { return "dateExtension.day".localized };
//            if lastDigit > 1 && lastDigit < 5 { return "dateExtension.day_rodit_padezh".localized };
//            if lastDigit == 0 || lastDigit >= 5 { return "dateExtension.days".localized };
//        }
//        return ""
//    }
//}

extension Date {
    
}
