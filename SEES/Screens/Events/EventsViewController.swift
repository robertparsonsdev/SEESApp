//
//  CalendarCollectionViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit

class EventsViewController: UIViewController {
    private var events: [Event] = []
    private let networkManager: NetworkManager
    
    private let segmentedControl = UISegmentedControl(items: ["Calendar View", "List View"])
    private let containerView = UIView()
    private var calendarGridVC: CalendarGridVC {
        let calendarVC = CalendarGridVC(events: self.events)
        return calendarVC
    }
    private var calendarListVC: CalendarListVC {
        let calendarListVC = CalendarListVC(events: self.events)
        return calendarListVC
    }
    
    // MARK: - Initializers
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureSegmentedControl()
        configureConstraints()
        
        fetchEvents()
    }
    
    // MARK: - Configuration Functions
    private func configureViewController() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.topItem?.title = "Upcoming Events"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let refreshButton = UIBarButtonItem(image: Symbol.refresh, style: .plain, target: self, action: #selector(refreshTapped))
        refreshButton.tintColor = .systemTeal
        self.navigationItem.rightBarButtonItem = refreshButton
    }
    
    private func configureSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(updateUI), for: .valueChanged)
    }
    
    private func configureConstraints() {
        view.addSubviews(segmentedControl, containerView)
        
        segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        containerView.anchor(top: segmentedControl.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // MARK: - Functions
    private func fetchEvents() {
        showLoadingView()
        self.networkManager.fetchData(for: .events) { [weak self] (result: Result<[Event], SEESError>) in
            guard let self = self else { return }
            self.dismissLoadingViewOnMainThread()
            
            switch result {
            case .success(let events):
                var filteredEvents = events.filter { $0.date >= Calendar.current.date(byAdding: .day, value: -1, to: Date())! }
                filteredEvents.sort { $0.date < $1.date }
                self.events = filteredEvents
            case .failure(let error):
                self.presentErrorOnMainThread(withError: error, optionalMessage: "\n\n\(error.localizedDescription)")
            }
            DispatchQueue.main.async { self.updateUI() }
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
    
    @objc private func refreshTapped() {
        fetchEvents()
    }
}
