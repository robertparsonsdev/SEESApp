//
//  CalendarListVC.swift
//  SEES
//
//  Created by Robert Parsons on 11/27/20.
//

import UIKit

private let cellIdentifier = "calendarListIdentifier"
class CalendarListVC: UITableViewController {
    private var events: [Event] = []
    
    // MARK: - Intializers
    init(events: [Event]) {
        super.init(nibName: nil, bundle: nil)
        
        self.events = events
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table View Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = self.events[indexPath.row].eventName
        cell.detailTextLabel?.text = self.events[indexPath.row].startDate.convertToString()
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetailVC = EventDetailViewController(event: self.events[indexPath.row])
        self.navigationController?.pushViewController(eventDetailVC, animated: true)
    }
    
    // MARK: - Configuration Functions
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}
