//
//  SEESMapView.swift
//  SEES
//
//  Created by Robert Parsons on 3/16/20.
//  Copyright © 2020 Robert Parsons. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class SEESMapView: MKMapView {
    private let regionRadius: CLLocationDistance = 1000
    private let locationTitle: String
    private let locationAddress: String
    private let locationCity: String
    private let locationState: String
    private let locationZIP: Int
    private let locationCountry: String
    
    private var location = CLLocation()
    private var annotation = MKPointAnnotation()
    private var placemark: MKPlacemark?
    
    init(title: String, address: String, city: String, state: String, zip: Int, country: String) {
        self.locationTitle = title
        self.locationAddress = address
        self.locationCity = city
        self.locationState = state
        self.locationZIP = zip
        self.locationCountry = country
        
        super.init(frame: .zero)
        
        configureMapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureMapView() {
        layer.cornerRadius = 14
        delegate = self
        
        convertToCoordinates() { [weak self] (location) in
            guard let self = self else { return }
            self.location = location
            self.centerMapOnLocation(location: location)
            self.configureAnnotation(withLocation: location)
        }
    }
    
    func convertToCoordinates(completion: @escaping (_ location: CLLocation) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(self.locationAddress) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else { return }
            completion(location)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
    func configureAnnotation(withLocation location: CLLocation) {
//        self.annotation.title = "\(locationTitle)\n\(locationAddress)"
//        self.annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        addAnnotation(annotation)
        
        // refactor database to include separate entries for address
        let coordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let address: [String: Any] = [CNPostalAddressStreetKey: self.locationAddress, CNPostalAddressCityKey: self.locationCity, CNPostalAddressStateKey: self.locationCity, CNPostalAddressPostalCodeKey: self.locationZIP, CNPostalAddressISOCountryCodeKey: self.locationCountry]
        
        self.placemark = MKPlacemark(coordinate: coordinates, addressDictionary: address)
        addAnnotation(self.placemark!)
    }
}

extension SEESMapView: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        let mapItem = MKMapItem(placemark: self.placemark!)
//        mapItem.name = "Test"
//        mapItem.openInMaps(launchOptions: nil)
//        mapView.deselectAnnotation(mapItem as? MKAnnotation, animated: true)
//    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let mapItem = MKMapItem(placemark: self.placemark!)
        mapItem.openInMaps(launchOptions: .none)
    }
}
