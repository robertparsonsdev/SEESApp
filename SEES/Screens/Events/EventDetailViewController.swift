//
//  EventDetailViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/28/20.
//

import UIKit

class EventDetailViewController: UIViewController {
    private let event: Event
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let whenMessage: SEESMessageView
    private let whereMessage: SEESMessageView
    private let notesMessage: SEESMessageView
    
    private let addToCalButton = SEESButton(backgroundColor: .systemRed, title: "Add to iPhone Calendar")
    
    // MARK: - Intializers
    init(event: Event) {
        self.event = event
        self.whenMessage = SEESMessageView(title: "When:", message: event.startDate.convertToString(), dimensions: .half)
        self.whereMessage = SEESMessageView(title: "Where:", message: event.locationName, dimensions: .half)
        self.notesMessage = SEESMessageView(title: "Notes:", titleAlignment: .left, message: event.notes, messageAlignment: .left, dimensions: .full)

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
    }
    
    private func configureConstraints() {
        view.addSubview(scrollView)
        scrollView.frame = self.view.frame

        let externalPadding: CGFloat = 20, internalPadding: CGFloat = 15
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = internalPadding
        stackView.addArrangedSubview(whenMessage)
        stackView.addArrangedSubview(whereMessage)

        scrollView.addSubviews(stackView, notesMessage, addToCalButton)
        
        let top = scrollView.topAnchor, leading = scrollView.leadingAnchor, trailing = scrollView.trailingAnchor, x = view.centerXAnchor
        stackView.anchor(top: top, leading: nil, bottom: nil, trailing: nil, x: x, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.view.frame.width - (externalPadding * 2), height: 100)
    }
}
