//
//  LoginViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit

class LoginViewController: UIViewController {
    private let networkManager: NetworkManager
    
    private let logoMultiplier: CGFloat = 0.5
    private var logoImageView: SEESContactImageView!
    private let broncoEmailTextField = SEESTextField(placeholder: "Bronco Email", keyboardType: .emailAddress, returnKeyType: .next)
    private let broncoIDTextField = SEESTextField(placeholder: "Bronco ID", keyboardType: .numberPad, returnKeyType: .go)
    private let loginButton = SEESButton(backgroundColor: .systemTeal, title: "Log In")
    private let warningLabel = SEESBodyLabel(textAlignment: .center, text: "You will need to have signed up for SEES and have received the \"Welcome to SEES!\" email before you are able to login to this app.")
    
    // MARK: - Intializers
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
        configureLogoImageView()
        configureTextField(textField: broncoEmailTextField, tag: 0)
        configureTextField(textField: broncoIDTextField, tag: 1)
        configureLoginButton()
        configureDismissKeyboardTapGesture()
        configureConstraints()
    }
    
    // MARK: - Configuration Functions
    fileprivate func configureViewController() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.isNavigationBarHidden = true
        self.isModalInPresentation = true
    }
    
    fileprivate func configureLogoImageView() {
        logoImageView = SEESContactImageView(cornerRadius: (self.view.frame.width * logoMultiplier) / 2, contact: .logo)
    }
    
    fileprivate func configureTextField(textField: SEESTextField, tag: Int) {
        textField.tag = tag
        textField.delegate = self
    }
    
    fileprivate func configureLoginButton() {
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    fileprivate func configureDismissKeyboardTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    fileprivate func configureConstraints() {
        let itemWidth = view.frame.width - 100, itemHeight: CGFloat = 40
        view.addSubviews(logoImageView, broncoEmailTextField, broncoIDTextField, loginButton, warningLabel)
        
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, x: view.centerXAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        logoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: logoMultiplier).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: logoMultiplier).isActive = true
        
        broncoEmailTextField.anchor(top: logoImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, x: view.centerXAnchor, y: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: itemHeight)
        broncoIDTextField.anchor(top: broncoEmailTextField.bottomAnchor, leading: nil, bottom: nil, trailing: nil, x: view.centerXAnchor, y: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: itemHeight)
        
        loginButton.anchor(top: broncoIDTextField.bottomAnchor, leading: nil, bottom: nil, trailing: nil, x: view.centerXAnchor, y: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: itemHeight)
        
        warningLabel.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, x: view.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth + 50, height: 0)
    }
    
    // MARK: - Selectors
    @objc func handleLogin() {
        guard let email = self.broncoEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let id = self.broncoIDTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard validateInput(of: email, for: .email) else { return }
        guard validateInput(of: id, for: .id) else { return }
        
        self.networkManager.login(withEmail: email, andPassword: id) { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    guard let mainTabBarController = self.view.window?.rootViewController as? MainTabBarController else { return }
                    mainTabBarController.configureViewControllers()
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                self.presentErrorOnMainThread(withError: .loginError, optionalMessage: "\n\n\(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Functions
    func validateInput(of input: String, for type: BroncoType) -> Bool {
        if input.isEmpty {
            switch type {
            case .email: presentErrorOnMainThread(withError: .missingEmail)
            case .id: presentErrorOnMainThread(withError: .missingID)
            }
            return false
        } else if type == .email && !(input ~= "^[a-zA-Z0-9]+@cpp.edu$") {
            presentErrorOnMainThread(withError: .incorrectEmail)
            return false
        } else if type == .id && !(input ~= "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$") {
            presentErrorOnMainThread(withError: .incorrectID)
            return false
        } else {
            return true
        }
    }
}

// MARK: - Delegates
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            handleLogin()
        }
        return true
    }
}
