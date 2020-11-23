//
//  HomeHeader.swift
//  SEES
//
//  Created by Robert Parsons on 11/18/20.
//

import UIKit

class HomeHeader: UICollectionReusableView {
    public static let identifer = "HomeHeader"
    
    private var advisorName = ""
    private var advisorOffice = ""
    
    private let stackView = UIStackView()
    private var advisorNameMessage: SEESMessageView!
    private var advisorOfficeMessage: SEESMessageView!
    private var infoMessage: SEESMessageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(name: String, office: String) {
        self.advisorName = name
        self.advisorOffice = office
        
        configureCell()
    }
    
    fileprivate func configureCell() {
        let externalPadding: CGFloat = 20, internalPadding: CGFloat = 15
        
        advisorNameMessage = SEESMessageView(title: "My Advisor:", message: self.advisorName)
        advisorOfficeMessage = SEESMessageView(title: "Advisor Office:", message: self.advisorOffice)
        infoMessage = SEESMessageView(title: nil, message: "SEES students are required to receive academic advising each semester. Instructions on how to do so can be found below along with major curriculum information.")
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = internalPadding
        stackView.addArrangedSubview(advisorNameMessage)
        stackView.addArrangedSubview(advisorOfficeMessage)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, x: centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.frame.width - (externalPadding * 2), height: self.frame.height / 2 - (internalPadding / 2) - externalPadding)
        addSubview(infoMessage)
        infoMessage.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil, x: centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.frame.width - (externalPadding * 2), height: self.frame.height / 2 - (internalPadding / 2) + externalPadding)
    }
}
