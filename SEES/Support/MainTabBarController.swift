//
//  MainTabBarController.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    let networkManager = NetworkManager.shared
    let persistence = PersistenceManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard Auth.auth().currentUser != nil else {
            DispatchQueue.main.async {
                self.present(UINavigationController(rootViewController: LoginViewController(networkManager: self.networkManager)), animated: true)
            }
            return
        }

        configureViewControllers()
    }
    
    func configureViewControllers() {
        let homeViewController = buildTabBarViewController(withTitle: "Home", andImage: UIImage(systemName: "house.fill")!, andRootVC: HomeCollectionViewController(networkManager: self.networkManager, persistence: self.persistence))
        let calendarViewController = buildTabBarViewController(withTitle: "Events", andImage: UIImage(systemName: "calendar")!, andRootVC: EventsCollectionViewController())
        let contactViewController = buildTabBarViewController(withTitle: "Contact Us", andImage: UIImage(systemName: "envelope.fill")!, andRootVC: ContactCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        self.viewControllers = [homeViewController, calendarViewController, contactViewController]
    }
    
    fileprivate func buildTabBarViewController(withTitle title: String, andImage image: UIImage, andRootVC root: UIViewController) -> UINavigationController {
        root.tabBarItem.image = image
        root.tabBarItem.title = title
        let navController = UINavigationController(rootViewController: root)
        navController.navigationBar.tintColor = .systemTeal
        return navController
    }
}
