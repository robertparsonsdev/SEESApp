//
//  LoginViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit

class LoginViewController: UIViewController {
    private let logoMultiplier: CGFloat = 0.625
    private var logoImageView: SEESLogoImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureLogoImageView()
        
        configureConstraints()
    }
    
    // MARK: - Configuration Functions
    fileprivate func configureViewController() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.isNavigationBarHidden = true
        self.isModalInPresentation = true
    }
    
    fileprivate func configureLogoImageView() {
        logoImageView = SEESLogoImageView(cornerRadius: (self.view.frame.width * logoMultiplier) / 2)
    }
    
    fileprivate func configureConstraints() {
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, x: view.centerXAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        logoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: logoMultiplier).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: logoMultiplier).isActive = true
    }
}
