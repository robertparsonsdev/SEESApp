//
//  HomeHeader.swift
//  SEES
//
//  Created by Robert Parsons on 11/18/20.
//

import UIKit

class HomeHeader: UICollectionReusableView {
    public static let identifer = "HomeHeader"
    
    private let stackView = UIStackView()
    private let advisorNameMessage = SEESMessageView()
    private let advisorOfficeMessage = SEESMessageView()
    private lazy var infoMessage: SEESMessageView = {
        return SEESMessageView(message: "SEES students are required to receive academic advising each semester. Instructions on how to do so can be found below along with major curriculum information.",
                               frame: CGRect(x: 0, y: 0, width: self.frame.width - (20 * 2), height: self.frame.height - 100 - 15))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(name: String, office: String) {
        advisorNameMessage.set(title: "My Advisor:", message: name)
        advisorOfficeMessage.set(title: "Advisor Office:", message: office)
    }
    
    fileprivate func configureCell() {
        let externalPadding: CGFloat = 20, internalPadding: CGFloat = 15
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = internalPadding
        stackView.addArrangedSubview(advisorNameMessage)
        stackView.addArrangedSubview(advisorOfficeMessage)
        
        addSubviews(stackView, infoMessage)
        
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeft: externalPadding, paddingBottom: 0, paddingRight: externalPadding, width: 0, height: 100)
        infoMessage.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: internalPadding, paddingLeft: externalPadding, paddingBottom: 0, paddingRight: externalPadding, width: 0, height: 0)
    }
}
