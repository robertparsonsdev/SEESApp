//
//  Enums.swift
//  SEES
//
//  Created by Robert Parsons on 11/15/20.
//

import UIKit

enum BroncoType {
    case email, id
}

enum SEESError: Error {
    case missingEmail, missingID, incorrectEmail, incorrectID
    case loginError, signOutError
    case unableToGetCurrentStudent, unableToRetrieveData
    case unableToSaveStudent, unableToRetrieveStudent
    case unableToLoadMajorInformation
    case unableToLoadEvents
    case unableToLoadWorksheet
    case unableToSaveEvent, unableToAccessCalendar
    case unableToSendEmail, unableToOpenPage, unableToLoadContacts
    
    var info: (title: String, message: String) {
        switch self {
        case .missingEmail: return ("Missing Bronco Email", "Please enter your Bronco email.\n Example: billybronco@cpp.edu")
        case .missingID: return ("Missing Bronco ID", "Please enter your 9 digit Bronco ID.")
        case .incorrectEmail: return ("Incorrect Email", "Please ensure that you entered your Bronco Email correctly.\nExample: billybronco@cpp.edu")
        case .incorrectID: return ("Incorrect Bronco ID", "Please ensure that you entered your 9 digit Bronco ID correctly.")
        case .loginError: return ("Unable to Log In", "If you are a SEES member and cannot log in, please report this error to the SEES Office.")
        case .signOutError: return ("Unable to Sign Out", "Make sure you are connected to the internet and try again.")
        case .unableToGetCurrentStudent: return ("Unable to Get Student", "Please ensure that you have an internet connection and are logged in.")
        case .unableToRetrieveData: return ("Unable to Retrieve Data", "Please ensure that you have an internet connection and are logged in.")
        case .unableToSaveStudent: return ("Unable to Save Student Data", "Please try restarting this app.")
        case .unableToRetrieveStudent: return ("Unable to Retrieve Student Data", "Please try restarting this app.")
        case .unableToLoadMajorInformation: return ("Unable to Load Major Information", "Not able to load information for this major's option. Either it doesn't exist or the connection is bad. Please report this to the SEES Office.")
        case .unableToLoadEvents: return ("Unable to Load Events", "Please try refreshing, ensuring you have an internet connection, or restarting the app.")
        case .unableToLoadWorksheet: return ("Unable to Load Advising Worksheet", "Please ensure you have an internet connection and if the problem persists, please inform the SEES Office.")
        case .unableToSaveEvent: return ("Unable to Save Event", "Please try restarting the app and try again.")
        case .unableToAccessCalendar: return ("Unable to Access Calendar", "You need to grant this app access to your calendar by going to Settings, Privacy, Calendars and making sure SEES is on.")
        case .unableToSendEmail: return ("Unable to Send Email", "Your device is not configured to send email. \n\nPlease visit the SEES page on the CPP website to view contact information.")
        case .unableToOpenPage: return ("Unable to Open Page", "Please ensure you have an internet connection. If you do, please inform the SEES office of this error: Unable to open SEES Contact Information webpage.")
        case .unableToLoadContacts: return ("Unable to Load Contacts", "Please try refreshing, ensuring you have an internet connection, or restarting the app.")
        }
    }
}

enum Keys {
    static let student = "student"
}

enum FBDataType {
    case students
    case options
    case events
    case contacts
    
    var key: String {
        switch self {
        case .students: return "students"
        case .options: return "options"
        case .events: return "events"
        case .contacts: return "contacts"
        }
    }
}

enum FBStudent: CaseIterable {
    case firstName
    case lastName
    case email
    case broncoID
    case advisor
    case advisorOffice
    
    var key: String {
        switch self {
        case .firstName: return "first-name"
        case .lastName: return "last-name"
        case .email: return "email"
        case .broncoID: return "bronco-id"
        case .advisor: return "advisor"
        case .advisorOffice: return "advisor-office"
        }
    }
}

enum FBOption: CaseIterable {
    case majorName
    case optionName
    case curriculumSheet
    case flowchart
    case roadMap
    
    var key: String {
        switch self {
        case .majorName: return "major-name"
        case .optionName: return "option-name"
        case .curriculumSheet: return "curriculum-sheet"
        case .flowchart: return "flowchart"
        case .roadMap: return "road-map"
        }
    }
}

enum FBEvent: CaseIterable {
    case eventName
    case date
    case notes
    case locationName
    case locationAddress
    case locationCity
    case locationState
    case locationZIP
    case locationCountry
    
    var key: String {
        switch self {
        case .eventName: return "event-name"
        case .date: return "date"
        case .notes: return "notes"
        case .locationName: return "location-name"
        case .locationAddress: return "location-address"
        case .locationCity: return "location-city"
        case .locationState: return "location-state"
        case .locationZIP: return "location-zip"
        case .locationCountry: return "location-country"
        }
    }
}

enum FBContact: CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case fullName
    case title
    case office
    case phone
    case email
    case order
    
    var key: String {
        switch self {
        case .monday: return "monday"
        case .tuesday: return "tuesday"
        case .wednesday: return "wednesday"
        case .thursday: return "thursday"
        case .friday: return "friday"
        case .fullName: return "full-name"
        case .title: return "title"
        case .office: return "office"
        case .phone: return "phone"
        case .email: return "email"
        case .order: return "order"
        }
    }
}

enum FBMajor: String, CaseIterable {
    case biology = "Biology"
    case biotech = "Biotechnology"
    case chem = "Chemistry"
    case cs = "Computer Science"
    case envBio = "Environmental Biology"
    case geo = "Geology"
    case kin = "Kinesiology"
    case math = "Mathematics"
    case phy = "Physics"
}

enum Dimensions {
    static let homeCellHeight: CGFloat = 100
    static let homeHeaderHeight: CGFloat = 270
    static let contactCellHeight: CGFloat = 225
    static let contactHeaderHeight: CGFloat = 200
}

enum Symbol {
    static let home = UIImage(systemName: "house.fill")!
    static let calendar = UIImage(systemName: "calendar")!
    static let envelope = UIImage(systemName: "envelope.fill")!
    static let refresh = UIImage(systemName: "arrow.clockwise")!
    static let phone = UIImage(systemName: "phone.fill")!
}

enum ContactImage {
    case logo
    case alas
    case dora
}

enum SVDay: String, CaseIterable {
    case monday = "M"
    case tuesday = "T"
    case wednesday = "W"
    case thursday = "Th"
    case friday = "F"
}

enum DateFormat {
    static let dateAndTime = "MMM d yyyy, h:mm a"
}

enum MajorTableItem: Int {
    case curriculumSheet, flowchart, roadMap
    var rowName: String {
        switch self {
        case .curriculumSheet: return "Curriculum Sheet"
        case .flowchart: return "Flowchart"
        case .roadMap: return "Road Map"
        }
    }
}
