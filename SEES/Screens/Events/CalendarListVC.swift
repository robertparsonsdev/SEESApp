//
//  CalendarListVC.swift
//  SEES
//
//  Created by Robert Parsons on 11/27/20.
//

import UIKit

class CalendarListVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    // MARK: - Configuration Functions
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
}
