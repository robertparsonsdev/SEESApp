//
//  MajorTableViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/26/20.
//

import UIKit

private let majorCellIdentifier = "majorCell"

class MajorTableViewController: UITableViewController {
    private let majorInfo: MajorInfo
    private var options: [Option] = []
    private let networkManager: NetworkManager
    
    private let refresh = UIRefreshControl()
    
    init(networkManager: NetworkManager, majorInfo: MajorInfo) {
        self.majorInfo = majorInfo
        self.networkManager = networkManager
        
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureRefresh()
        
        fetchOptions()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.options.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.options[section].optionName
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: majorCellIdentifier, for: indexPath)
        switch indexPath.row {
        case 0: cell.textLabel?.text = "Curriculum Sheet"
        case 1: cell.textLabel?.text = "Flowchart"
        case 2: cell.textLabel?.text = "Road Map"
        default: cell.textLabel?.text = "Error"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = self.options[indexPath.section]
        let urlString: String
        switch indexPath.row {
        case 0: urlString = option.curriculumSheet
        case 1: urlString = option.flowchart
        case 2: urlString = option.roadMap
        default: urlString = ""
        }
        
        guard let url = URL(string: urlString) else {
            presentErrorOnMainThread(withError: .unableToLoadMajorInformation)
            return
        }
        
        presentSafariVC(with: url)
    }
    
    // MARK: - Configuration Functions
    private func configureTableView() {
        self.title = self.majorInfo.name
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: majorCellIdentifier)
    }
    
    private func configureRefresh() {
        self.tableView.refreshControl = self.refresh
        self.refresh.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
    }
    
    // MARK: - Functions
    private func fetchOptions() {
        showLoadingView()
        self.networkManager.fetchMajor(for: self.majorInfo.networkName) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            self.endRefreshing()
            switch result {
            case .success(let major):
                self.options = major.options
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                self.presentErrorOnMainThread(withError: .unableToLoadMajorInformation, optionalMessage: "\n\n\(error.localizedDescription)")
            }
        }
    }
    
    private func endRefreshing() {
        DispatchQueue.main.async {
            if self.refresh.isRefreshing {
                self.refresh.endRefreshing()
            }
        }
    }
    
    // MARK: - Selectors
    @objc private func refreshPulled() {
        fetchOptions()
    }
}
