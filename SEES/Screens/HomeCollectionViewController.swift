//
//  HomeCollectionViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let networkManager: NetworkManager
    private var homeItems: [HomeItem] = []
    
    // MARK: - Initializers
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Collection View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        createHomeItems()
    }

    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeader.identifer, for: indexPath) as! HomeHeader
        header.backgroundColor = .tertiarySystemFill
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        let item = self.homeItems[indexPath.row]
        cell.backgroundColor = item.color
        cell.set(image: item.major.image, andText: item.major.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    // MARK: - Configuration Functions
    fileprivate func configureViewController() {
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.collectionViewLayout = UIHelper.createSingleColumnFlowLayout(in: self.collectionView)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        signOutButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = signOutButton
        
        self.collectionView!.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        self.collectionView!.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeader.identifer)
    }
    
    // MARK: - Functions
    fileprivate func createHomeItems() {
        self.homeItems.append(HomeItem(major: .academicAdvising, color: .systemGreen))
        self.homeItems.append(HomeItem(major: .biology, color: .systemTeal))
        self.homeItems.append(HomeItem(major: .biotech, color: .systemTeal))
        self.homeItems.append(HomeItem(major: .chemistry, color: .systemTeal))
        self.homeItems.append(HomeItem(major: .compSci, color: .systemTeal))
        self.homeItems.append(HomeItem(major: .envBio, color: .systemTeal))
        self.homeItems.append(HomeItem(major: .geology, color: .systemTeal))
        self.homeItems.append(HomeItem(major: .kin, color: .systemTeal))
        self.homeItems.append(HomeItem(major: .math, color: .systemTeal))
        self.homeItems.append(HomeItem(major: .physics, color: .systemTeal))
    }
    
    // MARK: - Selectors
    @objc fileprivate func signOut() {
        self.networkManager.signOut { (result) in
            switch result {
            case .success(let boolean): print(boolean)
            case .failure(let error): self.presentErrorOnMainThread(withError: .signOutError, optionalMessage: "\n\n\(error)")
            }
        }
    }
}
