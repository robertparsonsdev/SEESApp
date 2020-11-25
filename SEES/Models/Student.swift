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
        self.advisor = dictionary["advisor"] as? String ?? "advisorError"
        self.advisorOffice = dictionary["advisorOffice"] as? String ?? "advisorOfficeError"
        self.broncoID = dictionary["broncoID"] as? String ?? "broncoIDError"
        self.email = dictionary["email"] as? String ?? "emailError"
        self.firstName = dictionary["firstName"] as? String ?? "firstNameError"
        self.lastName = dictionary["lastName"] as? String ?? "lastNameError"
    }
}
