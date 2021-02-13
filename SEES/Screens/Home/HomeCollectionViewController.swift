//
//  HomeCollectionViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var student: Student?
    private let networkManager: NetworkManager
    private let persistence: PersistenceManager
    private var homeItems: [HomeItem] = []
    
    private let refresh = UIRefreshControl()
    
    // MARK: - Initializers
    init(networkManager: NetworkManager, persistence: PersistenceManager) {
        self.networkManager = networkManager
        self.persistence = persistence

        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Collection View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureRefresh()
        
        createHomeItems()
        fetchStudent()
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
        if let student = self.student {
            header.set(name: student.advisor, office: student.advisorOffice)
        }
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        let homeItem = self.homeItems[indexPath.row]
        cell.backgroundColor = homeItem.color
        cell.set(image: homeItem.info.image, andText: homeItem.info.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: Dimensions.homeHeaderHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let academicAdvisingVC = AcademicAdvisingVC()
            self.navigationController?.pushViewController(academicAdvisingVC, animated: true)
        default:
            let homeItemInfo = self.homeItems[indexPath.row].info
            let majorTable = MajorTableViewController(networkManager: self.networkManager, homeItemInfo: homeItemInfo)
            self.navigationController?.pushViewController(majorTable, animated: true)
        }
    }
    
    // MARK: - Configuration Functions
    private func configureViewController() {
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.collectionViewLayout = UIHelper.createSingleColumnFlowLayout(in: self.collectionView, cellHeight: Dimensions.homeCellHeight)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        signOutButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = signOutButton
        
        self.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        self.collectionView.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeader.identifer)
    }
    
    private func configureRefresh() {
        self.collectionView.refreshControl = self.refresh
        self.refresh.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
    }
    
    // MARK: - Functions
    private func createHomeItems() {
        for info in HomeItemInfo.allCases {
            switch info {
            case .academicAdvising:
                self.homeItems.append(HomeItem(info: info, color: .systemGreen))
            default:
                self.homeItems.append(HomeItem(info: info, color: .systemTeal))
            }
        }
    }
    
    private func fetchStudent() {
        self.persistence.retrieve { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let student):
                if let savedStudent = student {
                    self.reloadCollectionViewOnMainThread(with: savedStudent)
                } else {
                    self.fetchStudentFromNetwork()
                }
            case .failure(let error):
                print(error)
                self.fetchStudentFromNetwork()
            }
        }
    }
    
    private func fetchStudentFromNetwork() {
        DispatchQueue.main.async { self.refresh.beginRefreshing() }
        self.networkManager.fetchData(for: .students) { [weak self] (result: Result<[Student], SEESError>) in
            guard let self = self else { return }
            self.endRefreshingOnMainThread()
            
            switch result {
            case .success(let students):
                guard let student = students.getItemAt(0) else { self.presentErrorOnMainThread(withError: .unableToGetCurrentStudent); return }
                self.reloadCollectionViewOnMainThread(with: student)
                self.persistence.save(student: student)
            case .failure(let error):
                self.presentErrorOnMainThread(withError: error)
            }
        }
    }
    
    private func reloadCollectionViewOnMainThread(with student: Student) {
        DispatchQueue.main.async {
            self.student = student
            self.navigationController?.navigationBar.topItem?.title = "Welcome \(student.firstName)!"
            self.collectionView.reloadData()
        }
    }
    
    private func endRefreshingOnMainThread() {
        DispatchQueue.main.async {
            if self.refresh.isRefreshing {
                self.refresh.endRefreshing()
            }
        }
    }
    
    // MARK: - Selectors
    @objc private func signOut() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = .systemTeal
        alert.addAction(UIAlertAction(title: "Sign out", style: .destructive, handler: { (_) in
            self.networkManager.signOut { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    if let signedOutStudent = self.student { self.persistence.remove(student: signedOutStudent) }
                    let navController = UINavigationController(rootViewController: LoginViewController(networkManager: self.networkManager))
                    self.present(navController, animated: true)
                case .failure(let error): self.presentErrorOnMainThread(withError: .signOutError, optionalMessage: "\n\n\(error)")
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func refreshPulled() {
        fetchStudentFromNetwork()
    }
}
