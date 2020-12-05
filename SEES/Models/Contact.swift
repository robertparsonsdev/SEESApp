//
//  Contact.swift
//  SEES
//
//  Created by Robert Parsons on 12/4/20.
//

import Foundation

struct Contact {
    let name: String
    let title: String
    let office: String
    let phone: String
    let email: String
    let order: Int
    let image: ContactImage
    
    init(dictionary: [String: Any]) {
        self.name = dictionary[FirebaseValue.name] as? String ?? "nameError"
        self.title = dictionary[FirebaseValue.title] as? String ?? "titleError"
        self.office = dictionary[FirebaseValue.office] as? String ?? "officeError"
        self.phone = dictionary[FirebaseValue.phone] as? String ?? "phoneError"
        self.email = dictionary[FirebaseValue.email] as? String ?? "emailError"
        self.order = dictionary[FirebaseValue.order] as? Int ?? -1
        self.image = self.name.lowercased().contains("alas") ? .alas : .dora
    }
}