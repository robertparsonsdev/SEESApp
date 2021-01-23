//
//  DateExt.swift
//  SEES
//
//  Created by Robert Parsons on 11/28/20.
//

import Foundation

fileprivate var dateFormatter = DateFormatter()

extension Date {
    func convertToString() -> String {
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = DateFormat.dateAndTime
        
        return dateFormatter.string(from: self)
    }
    
    static func currentDate() -> Self {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date())
        return calendar.date(from: components)!
    }
}
