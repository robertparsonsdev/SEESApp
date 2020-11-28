//
//  CalendarCollectionViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit

class EventsCollectionViewController: UIViewController {
    private var events: [Event] = []
    private let networkManager: NetworkManager
    
    private let segmentedControl = UISegmentedControl(items: ["Calendar View", "List View"])
    private let containerView = UIView()
    private lazy var calendarGridVC: CalendarGridVC = {
        let calendarVC = CalendarGridVC()
        return calendarVC
    }()
    private lazy var calendarListVC: CalendarListVC = {
        let calendarListVC = CalendarListVC()
        return calendarListVC
    }()
    
    // MARK: - Initializers
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureSegmentedControl()
        configureConstraints()
        updateUI()
        
        fetchEvents()
    }
    
    // MARK: - Configuration Functions
    private func configureViewController() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.topItem?.title = "Upcoming Events"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(updateUI), for: .valueChanged)
    }
    
    private func configureConstraints() {
        view.addSubview(segmentedControl)
        segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, x: view.centerXAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(containerView)
        containerView.anchor(top: segmentedControl.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, x: view.centerXAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // MARK: - Functions
    private func fetchEvents() {
        self.networkManager.fetchEvents { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let events):
                self.events = events
                print(self.events)
            case .failure(let error):
                self.presentErrorOnMainThread(withError: error, optionalMessage: "\n\n\(error.localizedDescription)")
            }
        }
    }
    
    private func add(viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.didMove(toParent: self)
    }
    
    private func remove(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
    }
    
    // MARK: - Selectors
    @objc private func updateUI() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(viewController: self.calendarListVC)
            add(viewController: self.calendarGridVC)
        } else {
            remove(viewController: self.calendarGridVC)
            add(viewController: self.calendarListVC)
        }
    }
}
