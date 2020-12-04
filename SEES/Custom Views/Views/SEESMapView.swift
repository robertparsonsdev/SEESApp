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
    
    private var coordinate = CLLocationCoordinate2D()
    private var annotation = MKPointAnnotation()
    
    private lazy var mapErrorView: SEESMessageView = {
        return SEESMessageView(message: "There was an error loading this location's address. 😣\nPlease inform the SEES Office.", messageAlignment: .center, frame: .zero)
    }()
    
    init(title: String, address: String, city: String, state: String, zip: Int, country: String) {
        self.locationTitle = title
        self.locationAddress = address
        self.locationCity = city
        self.locationState = state
        self.locationZIP = zip
        self.locationCountry = country
        
        super.init(frame: .zero)
        
        createMapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createMapView() {
        layer.cornerRadius = 14
        delegate = self
        
        convertToCoordinate(forAddress: self.locationAddress) { [weak self] (coordinate) in
            guard let self = self else { return }
            guard let coordinate = coordinate else {
                self.addErrorOverlay()
                return
            }
            self.coordinate = coordinate
            self.centerMapOnLocation(withCoordinate: coordinate)
            self.configureAnnotation(withCoordinate: coordinate)
        }
    }
    
    private func convertToCoordinate(forAddress address: String, completion: @escaping (_ location: CLLocationCoordinate2D?) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard error == nil, let placemarks = placemarks else { completion(nil); return }
            completion(placemarks.first?.location?.coordinate)
        }
    }
    
    private func centerMapOnLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: self.regionRadius, longitudinalMeters: self.regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
    private func configureAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
        self.annotation.title = "\(self.locationTitle)\n\(self.locationAddress)\n\(self.locationCity), \(self.locationState) \(self.locationZIP)\nTap pin to open in Maps"
        self.annotation.coordinate = coordinate
        addAnnotation(annotation)
    }
    
    private func addErrorOverlay() {
        DispatchQueue.main.async {
            self.mapErrorView.backgroundColor = UIColor.tertiarySystemFill.withAlphaComponent(0.75)
            self.addSubview(self.mapErrorView)
            self.mapErrorView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        }
    }
}

extension SEESMapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: self.coordinate))
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsMapCenterKey: self.coordinate])
        mapView.deselectAnnotation(mapItem as? MKAnnotation, animated: true)
    }
}
