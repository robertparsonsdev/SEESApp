//
//  Event.swift
//  SEES
//
//  Created by Robert Parsons on 11/27/20.
//

import Foundation

struct Event {
    let startDate: Date
    let endDate: Date
    let eventName: String
    let locationName: String
    let locationAddress: String
    let locationCity: String
    let locationState: String
    let locationZIP: Int
    let locationCountry: String
    let notes: String
    
    init(dictionary: [String: Any]) {
        if let startDate = dictionary["startDate"] as? String {
            self.startDate = startDate.convertToDate() ?? Date()
        } else {
            self.startDate = Date()
        }
        
        if let endDate = dictionary["endDate"] as? String {
            self.endDate = endDate.convertToDate() ?? Date()
        } else {
            self.endDate = Date()
        }
        
        self.eventName = dictionary["eventName"] as? String ?? "eventNameError"
        self.locationName = dictionary["locationName"] as? String ?? "locationNameError"
        self.locationAddress = dictionary["locationAddress"] as? String ?? "locationAddressError"
        self.locationCity = dictionary["locationCity"] as? String ?? "locationCityError"
        self.locationState = dictionary["locationState"] as? String ?? "locationStateError"
        self.locationZIP = dictionary["locationZIP"] as? Int ?? -1
        self.locationCountry = dictionary["locationCountry"] as? String ?? "locationCountryError"
        self.notes = dictionary["notes"] as? String ?? "notesError"
    }
}
