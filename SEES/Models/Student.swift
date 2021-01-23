//
//  Student.swift
//  SEES
//
//  Created by Robert Parsons on 11/24/20.
//

import Foundation

struct Student: SEESDataModel, Codable {
    let advisor: String
    let advisorOffice: String
    let broncoID: String
    let email: String
    let firstName: String
    let lastName: String
    
    init(dictionary: [String: String]) {
        self.advisor = dictionary[FBStudent.advisor.key] ?? "advisorError"
        self.advisorOffice = dictionary[FBStudent.advisorOffice.key] ?? "advisorOfficeError"
        self.broncoID = dictionary[FBStudent.broncoID.key] ?? "broncoIDError"
        self.email = dictionary[FBStudent.email.key] ?? "emailError"
        self.firstName = dictionary[FBStudent.firstName.key] ?? "firstNameError"
        self.lastName = dictionary[FBStudent.lastName.key] ?? "lastNameError"
    }
}

protocol SEESDataModel {
    init(dictionary: [String: String])
}
