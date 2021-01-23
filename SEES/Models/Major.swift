//
//  Major.swift
//  SEES
//
//  Created by Robert Parsons on 11/25/20.
//

import Foundation

struct Option: Codable, Hashable {
    let majorName: String
    let optionName: String
    let curriculumSheet: String
    let flowchart: String
    let roadMap: String
    
    init(dictionary: [String: Any]) {
        self.majorName = dictionary[FBOption.majorName.key] as? String ?? "majorNameError"
        self.optionName = dictionary[FBOption.optionName.key] as? String ?? "optionNameError"
        self.curriculumSheet = dictionary[FBOption.curriculumSheet.key] as? String ?? "curriculumSheetError"
        self.flowchart = dictionary[FBOption.flowchart.key] as? String ?? "flowchartError"
        self.roadMap = dictionary[FBOption.roadMap.key] as? String ?? "roadMapError"
    }
}

//struct Major: Codable, Hashable {
//    var options: [Option] = []
//
//    init(dictionary: [String: [String: Any]]) {
//        for(_, value) in dictionary {
//            options.append(Option(dictionary: value))
//        }
//    }
//}
