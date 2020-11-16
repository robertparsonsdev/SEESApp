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
    private let broncoEmailTextField = SEESTextField(placeholder: "Bronco Email", keyboardType: .emailAddress, returnKeyType: .next)
    private let broncoIDTextField = SEESTextField(placeholder: "Bronco ID", keyboardType: .numberPad, returnKeyType: .go)
    private let loginButton = SEESButton(backgroundColor: .systemTeal, title: "Log In")
    private let warningLabel = SEESBodyLabel(textAlignment: .center, text: "You will need to have signed up for SEES and have received the \"Welcome to SEES!\" email before you are able to login to this app.")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addNotificationObservers()
        
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
        logoImageView = SEESLogoImageView(cornerRadius: (self.view.frame.width * logoMultiplier) / 2)
    }
    
    fileprivate func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, x: view.centerXAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        logoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: logoMultiplier).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: logoMultiplier).isActive = true
        
        view.addSubview(broncoEmailTextField)
        broncoEmailTextField.anchor(top: logoImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, x: view.centerXAnchor, y: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: itemHeight)
        view.addSubview(broncoIDTextField)
        broncoIDTextField.anchor(top: broncoEmailTextField.bottomAnchor, leading: nil, bottom: nil, trailing: nil, x: view.centerXAnchor, y: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: itemHeight)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: broncoIDTextField.bottomAnchor, leading: nil, bottom: nil, trailing: nil, x: view.centerXAnchor, y: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: itemHeight)
        
        view.addSubview(warningLabel)
        warningLabel.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, x: view.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth + 50, height: 0)
    }
    
    // MARK: - Selectors
    @objc func handleLogin() {
        guard let email = self.broncoEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = self.broncoIDTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard validateInput(of: email, for: .email) else { return }
        guard validateInput(of: password, for: .id) else { return }
        
        NetworkManager.shared.login(withEmail: email, andPassword: password) { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    // cast user to Student and pass to maintabbarcontroller (I think?)
                    guard let mainTabBarController = self.view.window?.rootViewController as? MainTabBarController else { return }
                    mainTabBarController.configureViewControllers()
                    self.dismiss(animated: true)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.presentAlertController(withTitle: "Error: Unable to Log In", andMessage: "If you are in fact a SEES member and cannot log in, please report this error to the SEES Office.")
                }
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
    }
    
    // MARK: - Functions
    func presentAlertController(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alertController, animated: true)
    }
    
    func validateInput(of input: String, for type: BroncoType) -> Bool {
        if input.isEmpty {
            switch type {
            case .email: presentAlertController(withTitle: "Missing Bronco Email", andMessage: "Please enter your Bronco email.\n Example: billybronco@cpp.edu")
            case .id: presentAlertController(withTitle: "Missing Bronco ID", andMessage: "Please enter your 9 digit Bronco ID.")
            }
            return false
        } else if type == .email && !(input ~= "^[a-zA-Z0-9]+@cpp.edu$") {
            presentAlertController(withTitle: "Incorrect Email", andMessage: "Please ensure that you entered your Bronco Email correctly.\nExample: billybronco@cpp.edu")
            return false
        } else if type == .id && !(input ~= "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$") {
            presentAlertController(withTitle: "Incorrect Bronco ID", andMessage: "Please ensure that you entered your 9 digit Bronco ID correctly.")
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

// MARK: - Enums
enum BroncoType: String {
    case email = "Email"
    case id = "ID"
}
