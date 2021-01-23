//
//  Contact.swift
//  SEES
//
//  Created by Robert Parsons on 12/4/20.
//

import Foundation

struct Contact {
    let fullName: String
    let title: String
    let office: String
    let phone: String
    let email: String
    let order: Int
    let image: ContactImage
    
    let monday: String
    let tuesday: String
    let wednesday: String
    let thursday: String
    let friday: String
    
    init(dictionary: [String: Any]) {
        self.fullName = dictionary[FBContact.fullName.key] as? String ?? "nameError"
        self.title = dictionary[FBContact.title.key] as? String ?? "titleError"
        self.office = dictionary[FBContact.office.key] as? String ?? "officeError"
        self.phone = dictionary[FBContact.phone.key] as? String ?? "phoneError"
        self.email = dictionary[FBContact.email.key] as? String ?? "emailError"
        self.order = dictionary[FBContact.order.key] as? Int ?? -1
        self.image = self.fullName.lowercased().contains("alas") ? .alas : .dora
        
        self.monday = dictionary[FBContact.monday.key] as? String ?? "mondayError"
        self.tuesday = dictionary[FBContact.tuesday.key] as? String ?? "tuesdayError"
        self.wednesday = dictionary[FBContact.wednesday.key] as? String ?? "wednesdayError"
        self.thursday = dictionary[FBContact.thursday.key] as? String ?? "thursdayError"
        self.friday = dictionary[FBContact.friday.key] as? String ?? "fridayError"
    }
}
