//
//  ContactCollectionViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit
import MessageUI

class ContactCollectionViewController: UICollectionViewController {
    private let networkManager: NetworkManager
    private let persistenceManager: PersistenceManager
    
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
    }

    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
        cell.set(delegate: self)
        return cell
    }

    // MARK: - Configuration Functions
    private func configureViewController() {
        self.title = "Contact Us"
        self.collectionView.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.collectionView.collectionViewLayout = UIHelper.createSingleColumnFlowLayout(in: self.collectionView, cellHeight: Dimensions.contactCellHeight)
        
        self.collectionView!.register(ContactCell.self, forCellWithReuseIdentifier: ContactCell.identifier)
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
        
        var subject: String = "", messageBody: String = ""
        self.persistenceManager.retrieve { (result) in
            switch result {
            case .success(let student):
                if let student = student {
                    subject = "SEES App: \(student.lastName), \(student.firstName)"
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
