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
    
    var networkName: String {
        switch self {
        case .academicAdvising: return ""
        case .biology: return "biology"
        case .biotechnology: return "biotechnology"
        case .chemistry: return "chemistry"
        case .computerScience: return "computerScience"
        case .environmentalBiology: return "environmentalBiology"
        case .geology: return "geology"
        case .kinesiology: return "kinesiology"
        case .mathematics: return "mathematics"
        case .physics: return "physics"
        }
    }
}

enum Keys {
    static let student = "student"
}
