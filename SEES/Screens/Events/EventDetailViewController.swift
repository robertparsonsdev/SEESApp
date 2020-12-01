//
//  EventDetailViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/28/20.
//

import UIKit
import EventKit

class EventDetailViewController: UIViewController {
    private let event: Event
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let whenMessage: SEESMessageView
    private let whereMessage: SEESMessageView
    private let notesMessage: SEESMessageView
    private let mapView: SEESMapView
    private let addToCalButton = SEESButton(backgroundColor: .systemRed, title: "Add to iPhone Calendar")
    
    // MARK: - Intializers
    init(event: Event) {
        self.event = event
        self.whenMessage = SEESMessageView(title: "When:", message: event.startDate.convertToString())
        self.whereMessage = SEESMessageView(title: "Where:", message: event.locationName)
        self.notesMessage = SEESMessageView(title: "Notes:", titleAlignment: .left, message: event.notes, messageAlignment: .left)
        self.mapView = SEESMapView(title: event.locationName, address: event.locationAddress, city: event.locationCity, state: event.locationState, zip: event.locationZIP, country: event.locationCountry)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        configureConstraints()
    }
    
    // MARK: - Configuration Functions
    private func configureViewController() {
        self.title = self.event.eventName
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.addToCalButton.addTarget(self, action: #selector(addToCalButtonTapped), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        view.addSubview(scrollView)
        scrollView.frame = self.view.frame
        scrollView.alwaysBounceVertical = true

        let externalPadding: CGFloat = 20, internalPadding: CGFloat = 15
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = internalPadding
        stackView.addArrangedSubview(whenMessage)
        stackView.addArrangedSubview(whereMessage)

        scrollView.addSubviews(stackView, notesMessage, addToCalButton, mapView)
        
        let top = scrollView.topAnchor, leading = view.leadingAnchor, trailing = view.trailingAnchor
        stackView.anchor(top: top, leading: view.leadingAnchor, bottom: nil, trailing: trailing, paddingTop: 0, paddingLeft: externalPadding, paddingBottom: 0, paddingRight: externalPadding, width: 0, height: 100)
        notesMessage.anchor(top: stackView.bottomAnchor, leading: leading, bottom: nil, trailing: trailing, paddingTop: internalPadding, paddingLeft: externalPadding, paddingBottom: 0, paddingRight: externalPadding, width: 0, height: 200)
        mapView.anchor(top: notesMessage.bottomAnchor, leading: leading, bottom: nil, trailing: trailing, paddingTop: internalPadding, paddingLeft: externalPadding, paddingBottom: 0, paddingRight: externalPadding, width: 0, height: 150)
        addToCalButton.anchor(top: mapView.bottomAnchor, leading: leading, bottom: nil, trailing: trailing, paddingTop: internalPadding, paddingLeft: externalPadding, paddingBottom: 0, paddingRight: externalPadding, width: 0, height: 40)
    }
    
    // MARK: - Selectors
    @objc private func addToCalButtonTapped() {
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized: insertEvent(store: eventStore)
        case .denied: print("Calendar access denied.")
        case .notDetermined:
            eventStore.requestAccess(to: .event) { [weak self] (granted, error) in
                guard let self = self else { return }
                if granted { self.insertEvent(store: eventStore) } else { print("Calendar access denied.") }
            }
        default: print("Default case.")
        }
    }
    
    func insertEvent(store: EKEventStore) {
        // refactor to handle missing times, coordinates, and event times
        let calendarEvent = EKEvent(eventStore: store)
        calendarEvent.calendar = store.defaultCalendarForNewEvents
        calendarEvent.title = event.eventName
        calendarEvent.startDate = event.startDate
        calendarEvent.endDate = event.endDate
        calendarEvent.location = event.locationAddress
        calendarEvent.notes = event.notes
        
        do {
            try store.save(calendarEvent, span: .thisEvent)
            presentAlertOnMainThread(withTitle: "Success!", andMessage: "This event was succesfully added to your calendar.")
        } catch let error {
            print("Error saving event:", error)
        }
    }
}
