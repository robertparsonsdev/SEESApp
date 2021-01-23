//
//  Contact.swift
//  SEES
//
//  Created by Robert Parsons on 12/4/20.
//

import Foundation

struct Contact: SEESDataModel {
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
    
    init(dictionary: [String: String]) {
        self.fullName = dictionary[FBContact.fullName.key] ?? "nameError"
        self.title = dictionary[FBContact.title.key] ?? "titleError"
        self.office = dictionary[FBContact.office.key] ?? "officeError"
        self.phone = dictionary[FBContact.phone.key] ?? "phoneError"
        self.email = dictionary[FBContact.email.key] ?? "emailError"
        
        self.monday = dictionary[FBContact.monday.key] ?? "mondayError"
        self.tuesday = dictionary[FBContact.tuesday.key] ?? "tuesdayError"
        self.wednesday = dictionary[FBContact.wednesday.key] ?? "wednesdayError"
        self.thursday = dictionary[FBContact.thursday.key] ?? "thursdayError"
        self.friday = dictionary[FBContact.friday.key] ?? "fridayError"
        
        if let order = dictionary[FBContact.order.key] {
            self.order = Int(order) ?? 0
        } else {
            self.order = 0
        }
        self.image = self.fullName.lowercased().contains("alas") ? .alas : .dora
    }
}
