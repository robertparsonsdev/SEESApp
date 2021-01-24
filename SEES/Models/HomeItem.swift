//
//  HomeItem.swift
//  SEES
//
//  Created by Robert Parsons on 11/18/20.
//

import UIKit

struct HomeItem {
    let info: HomeItemInfo
    let color: UIColor
}

enum HomeItemInfo: CaseIterable {
    case academicAdvising
    case biology, biotechnology, chemistry, computerScience, environmentalBiology, geology, kinesiology, mathematics, physics
    
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
}
