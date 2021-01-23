//
//  ArrayExt.swift
//  SEES
//
//  Created by Robert Parsons on 1/23/21.
//

import Foundation

extension Array {
    public func getItemAt(_ index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
