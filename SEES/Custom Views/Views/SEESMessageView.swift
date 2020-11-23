//
//  SEESMessageView.swift
//  SEES
//
//  Created by Robert Parsons on 11/22/20.
//

import UIKit

class SEESMessageView: UIView {
    private let titleSize: CGFloat
    private let titleLabel: SEESTitleLabel?
    private let messageLabel: SEESBodyLabel
    
    init(title: String?, titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String, messageAlignment: NSTextAlignment = .center) {
        self.titleSize = titleSize
        if let text = title {
            self.titleLabel = SEESTitleLabel(textAlignment: titleAlignment, text: text, fontSize: titleSize)
        } else {
            self.titleLabel = nil
        }
        self.messageLabel = SEESBodyLabel(textAlignment: messageAlignment, text: message)
        
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .tertiarySystemFill
        clipsToBounds = true
        layer.cornerRadius = 14
        
        let padding: CGFloat = 10
        if let titleLabel = self.titleLabel {
            addSubview(titleLabel)
            titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, x: centerXAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: 0, paddingRight: padding, width: 0, height: self.titleSize + 5)
            addSubview(messageLabel)
            messageLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, x: centerXAnchor, paddingTop: 0, paddingLeft: padding, paddingBottom: padding, paddingRight: padding, width: 0, height: 0)
        } else {
            addSubview(messageLabel)
            messageLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, x: centerXAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding, width: 0, height: 0)
        }
    }
}
