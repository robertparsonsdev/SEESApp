//
//  DateExt.swift
//  SEES
//
//  Created by Robert Parsons on 11/28/20.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.string(from: self)
    }
}
