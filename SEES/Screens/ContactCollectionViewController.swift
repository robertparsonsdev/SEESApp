//
//  ContactCollectionViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit

class ContactCollectionViewController: UICollectionViewController {
    private let networkManager: NetworkManager
    
    // MARK: - Initializers
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
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
