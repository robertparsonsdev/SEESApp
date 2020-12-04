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
        self.whenMessage = SEESMessageView(title: "When:", message: event.startDate.convertToString(), frame: .zero)
        self.whereMessage = SEESMessageView(title: "Where:", message: event.locationName, frame: .zero)
        self.notesMessage = SEESMessageView(title: "Notes:", titleAlignment: .left, message: event.notes, messageAlignment: .left, frame: .zero)
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
        let externalPadding: CGFloat = 20, internalPadding: CGFloat = 15
        let stackHeight: CGFloat = 100, notesHeight: CGFloat = 200, mapHeight: CGFloat = 150, buttonHeight: CGFloat = 45
        let contentHeight = stackHeight + notesHeight + mapHeight + buttonHeight + (4 * internalPadding)
        let top = scrollView.topAnchor, leading = view.leadingAnchor, trailing = view.trailingAnchor

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = internalPadding
        stackView.addArrangedSubview(whenMessage)
        stackView.addArrangedSubview(whereMessage)
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: contentHeight)
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.addSubviews(stackView, notesMessage, addToCalButton, mapView)
        stackView.anchor(top: top, leading: leading, bottom: nil, trailing: trailing, paddingTop: 0, paddingLeft: externalPadding, paddingBottom: 0, paddingRight: externalPadding, width: 0, height: stackHeight)
        notesMessage.anchor(top: stackView.bottomAnchor, leading: leading, bottom: nil, trailing: trailing, paddingTop: internalPadding, paddingLeft: externalPadding, paddingBottom: 0, paddingRight: externalPadding, width: 0, height: notesHeight)
        mapView.anchor(top: notesMessage.bottomAnchor, leading: leading, bottom: nil, trailing: trailing, paddingTop: internalPadding, paddingLeft: externalPadding, paddingBottom: 0, paddingRight: externalPadding, width: 0, height: mapHeight)
        addToCalButton.anchor(top: mapView.bottomAnchor, leading: leading, bottom: nil, trailing: trailing, paddingTop: internalPadding, paddingLeft: externalPadding, paddingBottom: 0, paddingRight: externalPadding, width: 0, height: buttonHeight)
    }
    
    // MARK: - Selectors
    @objc private func addToCalButtonTapped() {
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized: insertEvent(store: eventStore)
        case .denied: presentErrorOnMainThread(withError: .unableToAccessCalendar)
        case .notDetermined:
            eventStore.requestAccess(to: .event) { [weak self] (granted, error) in
                guard let self = self else { return }
                guard error == nil else { self.presentErrorOnMainThread(withError: .unableToAccessCalendar); return }
                
                if granted {
                    self.insertEvent(store: eventStore)
                } else {
                    self.presentErrorOnMainThread(withError: .unableToAccessCalendar)
                }
            }
        case .restricted: presentErrorOnMainThread(withError: .unableToAccessCalendar)
        @unknown default:
            fatalError()
        }
    }
    
    func insertEvent(store: EKEventStore) {
        let calendarEvent = EKEvent(eventStore: store)
        calendarEvent.calendar = store.defaultCalendarForNewEvents
        calendarEvent.title = event.eventName
        calendarEvent.startDate = event.startDate
        calendarEvent.endDate = event.endDate
        calendarEvent.location = "\(event.locationAddress), \(event.locationCity), \(event.locationState) \(event.locationZIP)"
        calendarEvent.notes = event.notes
        
        do {
            try store.save(calendarEvent, span: .thisEvent)
            presentAlertOnMainThread(withTitle: "Success!", andMessage: "This event was succesfully saved to your calendar.")
        } catch let error {
            presentErrorOnMainThread(withError: .unableToSaveEvent, optionalMessage: "\n\n\(error.localizedDescription)")
        }
    }
}
