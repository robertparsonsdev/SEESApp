//
//  StringExt.swift
//  SEES
//
//  Created by Robert Parsons on 2/16/20.
//  Copyright © 2020 Robert Parsons. All rights reserved.
//

import Foundation

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}
