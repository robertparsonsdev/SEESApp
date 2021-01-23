//
//  Event.swift
//  SEES
//
//  Created by Robert Parsons on 11/27/20.
//

import Foundation

struct Event {
    let date: Date
//    let endDate: Date
    let eventName: String
    let locationName: String
    let locationAddress: String
    let locationCity: String
    let locationState: String
    let locationZIP: Int
    let locationCountry: String
    let notes: String
    
    init(dictionary: [String: Any]) {
//        if let startDate = dictionary[FBEvent.startDate.key] as? String {
//            self.startDate = startDate.convertToDate() ?? Date()
//        } else {
//            self.startDate = Date()
//        }
        
//        if let endDate = dictionary[FBEvent.endDate.key] as? String {
//            self.endDate = endDate.convertToDate() ?? Date()
//        } else {
//            self.endDate = Date()
//        }
        
        if let dateString = dictionary[FBEvent.date.key] as? String {
            self.date = dateString.convertToDate()
        } else {
            self.date = Date()
        }
        
        self.eventName = dictionary[FBEvent.eventName.key] as? String ?? "eventNameError"
        self.locationName = dictionary[FBEvent.locationName.key] as? String ?? "locationNameError"
        self.locationAddress = dictionary[FBEvent.locationAddress.key] as? String ?? "locationAddressError"
        self.locationCity = dictionary[FBEvent.locationCity.key] as? String ?? "locationCityError"
        self.locationState = dictionary[FBEvent.locationState.key] as? String ?? "locationStateError"
        self.locationZIP = dictionary[FBEvent.locationZIP.key] as? Int ?? -1
        self.locationCountry = dictionary[FBEvent.locationCountry.key] as? String ?? "locationCountryError"
        self.notes = dictionary[FBEvent.notes.key] as? String ?? "notesError"
    }
}
