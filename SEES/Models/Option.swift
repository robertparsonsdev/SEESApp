//
//  Major.swift
//  SEES
//
//  Created by Robert Parsons on 11/25/20.
//

import Foundation

struct Option: SEESDataModel {
    let majorName: String
    let optionName: String
    let curriculumSheet: String
    let flowchart: String
    let roadMap: String
    
    init(dictionary: [String: String]) {
        self.majorName = dictionary[FBOption.majorName.key] ?? "majorNameError"
        self.optionName = dictionary[FBOption.optionName.key] ?? "optionNameError"
        self.curriculumSheet = dictionary[FBOption.curriculumSheet.key] ?? "curriculumSheetError"
        self.flowchart = dictionary[FBOption.flowchart.key] ?? "flowchartError"
        self.roadMap = dictionary[FBOption.roadMap.key] ?? "roadMapError"
    }
}
