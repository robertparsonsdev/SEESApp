//
//  Event.swift
//  SEES
//
//  Created by Robert Parsons on 11/27/20.
//

import Foundation

struct Event: SEESDataModel {
    let date: Date
    let eventName: String
    let locationName: String
    let locationAddress: String
    let locationCity: String
    let locationState: String
    let locationZIP: String
    let locationCountry: String
    let notes: String
    
    init(dictionary: [String: String]) {
        if let dateString = dictionary[FBEvent.date.key] {
            self.date = dateString.convertToDate()
        } else {
            self.date = Date()
        }
        
        self.eventName = dictionary[FBEvent.eventName.key] ?? "eventNameError"
        self.locationName = dictionary[FBEvent.locationName.key] ?? "locationNameError"
        self.locationAddress = dictionary[FBEvent.locationAddress.key] ?? "locationAddressError"
        self.locationCity = dictionary[FBEvent.locationCity.key] ?? "locationCityError"
        self.locationState = dictionary[FBEvent.locationState.key] ?? "locationStateError"
        self.locationZIP = dictionary[FBEvent.locationZIP.key] ?? "locationZIPError"
        self.locationCountry = dictionary[FBEvent.locationCountry.key] ?? "locationCountryError"
        self.notes = dictionary[FBEvent.notes.key] ?? "notesError"
    }
}
