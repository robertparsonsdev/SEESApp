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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureLogoImageView()
        configureTextField(textField: broncoEmailTextField, tag: 0)
        configureTextField(textField: broncoIDTextField, tag: 1)
        configureLoginButton()
        configureDismissKeyboardTapGesture()
        configureConstraints()
        
        print(logoImageView.frame.height)
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
    }
    
    // MARK: - Selectors
    @objc func handleLogin() {
        guard let email = self.broncoEmailTextField.text, let password = self.broncoIDTextField.text else { return }
        guard validateInput(of: email, for: .email) else { return }
        guard validateInput(of: password, for: .id) else { return }
        print(email)
        print(password)
    }
    
    // MARK: - Functions
    func presentAlertController(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alertController, animated: true)
    }
    
    func validateInput(of input: String, for type: BroncoType) -> Bool {
        if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            switch type {
            case .email: presentAlertController(withTitle: "Missing Bronco Email", andMessage: "Please enter your Bronco email.\n Example: billybronco@cpp.edu")
            case .id: presentAlertController(withTitle: "Missing Bronco ID", andMessage: "Please enter your 9 digit Bronco ID.")
            }
            return false
        } else if type == .email && !(input.trimmingCharacters(in: .whitespacesAndNewlines) ~= "^[a-zA-Z0-9]+@cpp.edu$") {
            presentAlertController(withTitle: "Incorrect Email", andMessage: "Please ensure that you entered your Bronco Email correctly.\nExample: billybronco@cpp.edu")
            return false
        } else if type == .id && !(input.trimmingCharacters(in: .whitespacesAndNewlines) ~= "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$") {
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
