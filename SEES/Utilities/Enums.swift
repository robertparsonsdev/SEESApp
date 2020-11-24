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

enum SEESError {
    case missingEmail, missingID, incorrectEmail, incorrectID
    case loginError, signOutError
    
    var info: (title: String, message: String) {
        switch self {
        case .missingEmail: return ("Missing Bronco Email", "Please enter your Bronco email.\n Example: billybronco@cpp.edu")
        case .missingID: return ("Missing Bronco ID", "Please enter your 9 digit Bronco ID.")
        case .incorrectEmail: return ("Incorrect Email", "Please ensure that you entered your Bronco Email correctly.\nExample: billybronco@cpp.edu")
        case .incorrectID: return ("Incorrect Bronco ID", "Please ensure that you entered your 9 digit Bronco ID correctly.")
        case .loginError: return ("Unable to Log In", "If you are a SEES member and cannot log in, please report this error to the SEES Office.")
        case .signOutError: return ("Unable to Sign Out", "Make sure you are connected to the internet and try again.")
        }
    }
}

enum Major {
    case academicAdvising, biology, biotech, chemistry, compSci, envBio, geology, kin, math, physics
    
    var name: String {
        switch self {
        case .academicAdvising: return "Academic Advising"
        case .biology: return "Biology"
        case .biotech: return "Biotechnology"
        case .chemistry: return "Chemistry"
        case .compSci: return "Computer Science"
        case .envBio: return "Environmental Biology"
        case .geology: return "Geology"
        case .kin: return "Kinesiology"
        case .math: return "Mathematics"
        case .physics: return "Physics"
        }
    }
    
    var image: UIImage {
        switch self {
        case .academicAdvising: return UIImage(named: "checkmark")!
        case .biology: return UIImage(named: "bio")!
        case .biotech: return UIImage(named: "biotech")!
        case .chemistry: return UIImage(named: "chem")!
        case .compSci: return UIImage(named: "cs")!
        case .envBio: return UIImage(named: "env-bio")!
        case .geology: return UIImage(named: "geo")!
        case .kin: return UIImage(named: "kin")!
        case .math: return UIImage(named: "math")!
        case .physics: return UIImage(named: "phy")!
        }
    }
}