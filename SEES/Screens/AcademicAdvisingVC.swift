//
//  AcademicAdvisingVC.swift
//  SEES
//
//  Created by Robert Parsons on 12/1/20.
//

import UIKit

class AcademicAdvisingVC: UIViewController {
    let stepsMessage = SEESMessageView()
    let cell = HomeCell()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureStepsMessage()
        configureCell()
        configureButton()
        configureConstraints()
    }
    
    private func configureView() {
        self.title = "Academic Advising"
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureStepsMessage() {
        let stepAttribute = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        let steps = NSMutableAttributedString(string: "Step 1:\n", attributes: stepAttribute)
        steps.append(NSAttributedString(string: "Download and print the Advising Worksheet (below) or pick one up from the SEES Office and fill it out completely.\n"))
        steps.append(NSAttributedString(string: "Step 2:\n", attributes: stepAttribute))
        steps.append(NSAttributedString(string: "Make an appointment with your advisor (or department) to discuss your planned courses on your Advising Worksheet.\n"))
        steps.append(NSAttributedString(string: "Step 3:\n", attributes: stepAttribute))
        steps.append(NSAttributedString(string: "Return your signed Advising Worksheet to the SEES Office (3-2123) before your registration date."))
        
        stepsMessage.set(attributedMessage: steps, messageAlignment: .left)
    }
    
    private func configureCell() {
        cell.set(image: UIImage(named: "clipboard")!, andText: "Advising Worksheet")
        cell.backgroundColor = .systemGreen
        cell.isUserInteractionEnabled = false
    }
    
    private func configureButton() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.clipsToBounds = true
    }
    
    private func configureConstraints() {
        view.addSubviews(stepsMessage, button)
        button.addSubview(cell)
        
        stepsMessage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 300)
        button.anchor(top: stepsMessage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 100)
        cell.anchor(top: button.topAnchor, leading: button.leadingAnchor, bottom: button.bottomAnchor, trailing: button.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc private func buttonTapped() {
        guard let worksheetURL = URL(string: "https://www.cpp.edu/~sci/sees/docs/advising_worksheet.pdf") else {
            self.presentErrorOnMainThread(withError: .unableToLoadWorksheet)
            return
        }
        
        presentSafariVCOnMainThread(with: worksheetURL)
    }
}
