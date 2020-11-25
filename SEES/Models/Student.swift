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
    
    init(dictionary: [String: String]) {
        self.advisor = dictionary["advisor"] ?? "advisorError"
        self.advisorOffice = dictionary["advisorOffice"] ?? "advisorOfficeError"
        self.broncoID = dictionary["broncoID"] ?? "broncoIDError"
        self.email = dictionary["email"] ?? "emailError"
        self.firstName = dictionary["firstName"] ?? "firstNameError"
        self.lastName = dictionary["lastName"] ?? "lastNameError"
    }
}
