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
    case unableToSendEmail, unableToOpenPage
    
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
        case .unableToLoadEvents: return ("Unable to Load Events", "Please try refreshing or restarting the app.")
        case .unableToLoadWorksheet: return ("Unable to Load Advising Worksheet", "Please ensure you have an internet connection and if the problem persists, please inform the SEES Office.")
        case .unableToSaveEvent: return ("Unable to Save Event", "Please try restarting the app and try again.")
        case .unableToAccessCalendar: return ("Unable to Access Calendar", "You need to grant this app access to your calendar by going to Settings, Privacy, Calendars and making sure SEES is on.")
        case .unableToSendEmail: return ("Unable to Send Email", "Your device is not configured to send email. Please visit the SEES page on the CPP website to view email information.")
        case .unableToOpenPage: return ("Unable to Open Page", "Please ensure you have an internet connection. If you do, please inform the SEES office of this error: Unable to open SEES Contact Information webpage.")
        }
    }
}

enum MajorInfo {
    case academicAdvising, biology, biotechnology, chemistry, computerScience, environmentalBiology, geology, kinesiology, mathematics, physics
    
    var name: String {
        switch self {
        case .academicAdvising: return "Academic Advising"
        case .biology: return "Biology"
        case .biotechnology: return "Biotechnology"
        case .chemistry: return "Chemistry"
        case .computerScience: return "Computer Science"
        case .environmentalBiology: return "Environmental Biology"
        case .geology: return "Geology"
        case .kinesiology: return "Kinesiology"
        case .mathematics: return "Mathematics"
        case .physics: return "Physics"
        }
    }
    
    var image: UIImage {
        switch self {
        case .academicAdvising: return UIImage(named: "checkmark")!
        case .biology: return UIImage(named: "bio")!
        case .biotechnology: return UIImage(named: "biotech")!
        case .chemistry: return UIImage(named: "chem")!
        case .computerScience: return UIImage(named: "cs")!
        case .environmentalBiology: return UIImage(named: "env-bio")!
        case .geology: return UIImage(named: "geo")!
        case .kinesiology: return UIImage(named: "kin")!
        case .mathematics: return UIImage(named: "math")!
        case .physics: return UIImage(named: "phy")!
        }
    }
    
    var firebaseValue: String {
        switch self {
        case .academicAdvising: return ""
        case .biology: return FirebaseValue.biology
        case .biotechnology: return FirebaseValue.biotechnology
        case .chemistry: return FirebaseValue.chemistry
        case .computerScience: return FirebaseValue.computerScience
        case .environmentalBiology: return FirebaseValue.environmentalBiology
        case .geology: return FirebaseValue.geology
        case .kinesiology: return FirebaseValue.kinesiology
        case .mathematics: return FirebaseValue.mathematics
        case .physics: return FirebaseValue.physics
        }
    }
}

enum Keys {
    static let student = "student"
}

enum FirebaseValue {
    static let users = "users", majors = "majors", events = "events"
    
    static let advisor = "advisor"
    static let advisorOffice = "advisorOffice"
    static let broncoID = "broncoID"
    static let email = "email"
    static let firstName = "firstName"
    static let lastName = "lastName"
    
    static let biology = "biology"
    static let biotechnology = "biotechnology"
    static let chemistry = "chemistry"
    static let computerScience = "computerScience"
    static let environmentalBiology = "environmentalBiology"
    static let geology = "geology"
    static let kinesiology = "kinesiology"
    static let mathematics = "mathematics"
    static let physics = "physics"
    
    static let optionName = "optionName"
    static let curriculumSheet = "curriculumSheet"
    static let flowchart = "flowchart"
    static let roadMap = "roadMap"
    
    static let eventName = "eventName"
    static let startDate = "startDate"
    static let endDate = "endDate"
    static let locationName = "locationName"
    static let locationAddress = "locationAddress"
    static let locationCity = "locationCity"
    static let locationState = "locationState"
    static let locationZIP = "locationZIP"
    static let locationCountry = "locationCountry"
    static let notes = "notes"
}

enum Dimensions {
    static let homeCellHeight: CGFloat = 100
    static let homeHeaderHeight: CGFloat = 270
    static let contactCellHeight: CGFloat = 200
}

enum Symbol {
    static let home = UIImage(systemName: "house.fill")!
    static let calendar = UIImage(systemName: "calendar")!
    static let envelope = UIImage(systemName: "envelope.fill")!
    static let refresh = UIImage(systemName: "arrow.clockwise")!
    static let phone = UIImage(systemName: "phone.fill")!
}

enum Contact {
    case logo
    case alas
    case dora
}
