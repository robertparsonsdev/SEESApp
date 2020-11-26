//
//  Major.swift
//  SEES
//
//  Created by Robert Parsons on 11/25/20.
//

import Foundation

struct Option: Codable, Hashable {
    let optionName: String
    let curriculumSheet: String
    let flowchart: String
    let roadMap: String
    
    init(dictionary: [String: Any]) {
        self.optionName = dictionary["optionName"] as? String ?? "optionNameError"
        self.curriculumSheet = dictionary["curriculumSheet"] as? String ?? "curriculumSheetError"
        self.flowchart = dictionary["flowchart"] as? String ?? "flowchartError"
        self.roadMap = dictionary["roadMap"] as? String ?? "roadMapError"
    }
}

struct Major: Codable, Hashable {
    var options: [Option] = []
    
    init(dictionary: [String: [String: Any]]) {
        for(_, value) in dictionary {
            options.append(Option(dictionary: value))
        }
    }
}
