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
        self.advisor = dictionary[FirebaseValue.advisor] as? String ?? "advisorError"
        self.advisorOffice = dictionary[FirebaseValue.advisorOffice] as? String ?? "advisorOfficeError"
        self.broncoID = dictionary[FirebaseValue.broncoID] as? String ?? "broncoIDError"
        self.email = dictionary[FirebaseValue.email] as? String ?? "emailError"
        self.firstName = dictionary[FirebaseValue.firstName] as? String ?? "firstNameError"
        self.lastName = dictionary[FirebaseValue.lastName] as? String ?? "lastNameError"
    }
}
