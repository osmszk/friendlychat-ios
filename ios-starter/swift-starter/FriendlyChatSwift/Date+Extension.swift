//
//  Date+Extension.swift
//  FriendlyChatSwift
//
//  Created by 鈴木治 on 2018/04/15.
//  Copyright © 2018年 Google Inc. All rights reserved.
//

import UIKit

extension Date {
    
    static func diffStringFromDate(_ date: Date, onChat: Bool = false) -> String {
        let cal = Calendar.current
        let componentsToday = (cal as NSCalendar).components([.era , .year , .month , .day, .weekday], from: Date())
        let componentsParam = (cal as NSCalendar).components([.era , .year , .month , .day, .weekday], from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let jaDateFormatter: DateFormatter = DateFormatter()
        jaDateFormatter.locale = Locale(identifier: "ja")
        if cal.isDateInToday(date) {
            dateFormatter.dateFormat = "H:mm"
            return onChat ? "今日" : dateFormatter.string(from: date)
        } else if cal.isDateInYesterday(date) {
            return "昨日"
        } else if componentsToday.year == componentsParam.year {
            if onChat {
                dateFormatter.dateFormat = "M/d"
                let weekdaySymbolIndex = componentsParam.weekday! - 1
                let weekdayJa = jaDateFormatter.shortWeekdaySymbols[weekdaySymbolIndex]
                return dateFormatter.string(from: date) + "(" + weekdayJa + ")"
            } else {
                dateFormatter.dateFormat = "M/dd"
                return dateFormatter.string(from: date)
            }
        } else {
            dateFormatter.dateFormat = "yyyy/MM/dd"
            return dateFormatter.string(from: date)
        }
        //同日 mm:ss
        //昨日 昨日
        //一昨日〜同じ年 MM/dd
        //去年〜 yyyy/MM/dd
    }
    
    fileprivate static func componentFlags() -> NSCalendar.Unit {
        return [NSCalendar.Unit.year,
                NSCalendar.Unit.month,
                NSCalendar.Unit.day,
                NSCalendar.Unit.weekOfYear,
                NSCalendar.Unit.hour,
                NSCalendar.Unit.minute,
                NSCalendar.Unit.second,
                NSCalendar.Unit.weekday,
                NSCalendar.Unit.weekdayOrdinal,
                NSCalendar.Unit.weekOfYear]
    }
    
    fileprivate static func components(fromDate: Date) -> DateComponents! {
        return (Calendar.current as NSCalendar).components(Date.componentFlags(), from: fromDate)
    }
    
    func isEqualToDateIgnoringTime(_ date: Date) -> Bool
    {
        let comp1 = Date.components(fromDate: self)
        let comp2 = Date.components(fromDate: date)
        return ((comp1!.year == comp2!.year) && (comp1!.month == comp2!.month) && (comp1!.day == comp2!.day))
    }
}
