//
//  Student.swift
//  SEES
//
//  Created by Robert Parsons on 11/24/20.
//

import Foundation

struct Student: Codable, Hashable {
    let advisor: String
    let advisorOffice: String
    let broncoID: String
    let email: String
    let firstName: String
    let lastName: String
    
    init(dictionary: [String: Any]) {
        self.advisor = dictionary[FBStudent.advisor.key] as? String ?? "advisorError"
        self.advisorOffice = dictionary[FBStudent.advisorOffice.key] as? String ?? "advisorOfficeError"
        self.broncoID = dictionary[FBStudent.broncoID.key] as? String ?? "broncoIDError"
        self.email = dictionary[FBStudent.email.key] as? String ?? "emailError"
        self.firstName = dictionary[FBStudent.firstName.key] as? String ?? "firstNameError"
        self.lastName = dictionary[FBStudent.lastName.key] as? String ?? "lastNameError"
    }
}
