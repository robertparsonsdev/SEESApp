//
//  ContactCollectionViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit
import MessageUI

class ContactCollectionViewController: UICollectionViewController {
    private var contacts: [Contact] = []
    private let networkManager: NetworkManager
    private let persistenceManager: PersistenceManager
    private let refresh = UIRefreshControl()
    
    // MARK: - Initializers
    init(networkManager: NetworkManager, persistence: PersistenceManager) {
        self.networkManager = networkManager
        self.persistenceManager = persistence
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Collection View Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        
        showLoadingView()
        fetchContacts()
    }

    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
        cell.set(contact: self.contacts[indexPath.row], delegate: self)
        return cell
    }

    // MARK: - Configuration Functions
    private func configureViewController() {
        self.title = "Contact Us"
        self.collectionView.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.collectionView.collectionViewLayout = UIHelper.createSingleColumnFlowLayout(in: self.collectionView, cellHeight: Dimensions.contactCellHeight)
        self.collectionView.refreshControl = self.refresh
        self.refresh.addTarget(self, action: #selector(refreshPulled), for: .allEvents)
        
        self.collectionView!.register(ContactCell.self, forCellWithReuseIdentifier: ContactCell.identifier)
    }
    
    // MARK: - Functions
    private func fetchContacts() {
        self.networkManager.fetchContacts { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            self.endRefreshing()
            
            switch result {
            case .success(var contacts):
                contacts.sort { $0.order < $1.order }
                self.contacts = contacts
                DispatchQueue.main.async { self.collectionView.reloadData() }
            case .failure(let error):
                self.presentErrorOnMainThread(withError: error, optionalMessage: "\n\n\(error.localizedDescription)")
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
        fetchContacts()
    }
}

// MARK: - Delegates
extension ContactCollectionViewController: ContactCellDelegate {
    @objc func callButtonTapped(withNumber number: String) {
        guard let phoneURL = URL(string: "tel://\(number)") else { return }
        
        UIApplication.shared.open(phoneURL)
    }
    
    @objc func emailButtonTapped(withEmail email: String) {
        guard MFMailComposeViewController.canSendMail() else {
            let errorInfo = SEESError.unableToSendEmail.info
            let alert = UIAlertController(title: errorInfo.title, message: errorInfo.message, preferredStyle: .alert)
            alert.view.tintColor = .systemTeal
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Open SEES Page", style: .default, handler: { [weak self] (action) in
                guard let self = self else { return }
                guard let url = URL(string: "https://www.cpp.edu/sci/sees/contact-information.shtml") else { self.presentErrorOnMainThread(withError: .unableToOpenPage); return }
                self.presentSafariVCOnMainThread(with: url)
            }))
            
            present(alert, animated: true)
            return
        }
        
        var subject: String = "SEES App: ", messageBody: String = ""
        self.persistenceManager.retrieve { (result) in
            switch result {
            case .success(let student):
                if let student = student {
                    messageBody = "Name: \(student.firstName) \(student.lastName)\nBronco ID: \(student.broncoID)\n\nPlease compose your email here:\n"
                }
            case .failure(_): break
            }
        }
        
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = self
        mailViewController.setToRecipients([email])
        mailViewController.setSubject(subject)
        mailViewController.setMessageBody(messageBody, isHTML: false)
        
        present(mailViewController, animated: true)
    }
}

extension ContactCollectionViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
