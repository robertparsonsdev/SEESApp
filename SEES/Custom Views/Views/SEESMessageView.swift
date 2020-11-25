//
//  SEESMessageView.swift
//  SEES
//
//  Created by Robert Parsons on 11/22/20.
//

import UIKit

class SEESMessageView: UIView {
    private var titleSize: CGFloat = 20
    private var titleLabel: SEESTitleLabel?
    private let messageLabel = SEESBodyLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureView()
    }
    
    private convenience init(titleSize: CGFloat?) {
        self.init(frame: .zero)
        
        if let size = titleSize {
            self.titleSize = size
            self.titleLabel = SEESTitleLabel()
        } else {
            self.titleSize = 0
            self.titleLabel = nil
        }
        
        configureConstraints()
    }
    
    convenience init(title: String, titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String, messageAlignment: NSTextAlignment = .center) {
        self.init(titleSize: titleSize)
        
        set(title: title, titleSize: titleSize, titleAlignment: titleAlignment, message: message, messageAlignment: messageAlignment)
    }
    
    convenience init(message: String, messageAlignment: NSTextAlignment = .center) {
        self.init(titleSize: nil)
        
        set(message: message, messageAlignment: messageAlignment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(title: String, titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String, messageAlignment: NSTextAlignment = .center) {
        self.titleLabel = SEESTitleLabel(textAlignment: titleAlignment, text: title, fontSize: self.titleSize)
        self.messageLabel.set(textAlignment: messageAlignment, text: message)
        configureConstraints()
    }
    
    public func set(message: String, messageAlignment: NSTextAlignment = .center) {
        self.messageLabel.set(textAlignment: messageAlignment, text: message)
        configureConstraints()
    }
    
    private func configureView() {
        backgroundColor = .tertiarySystemFill
        clipsToBounds = true
        layer.cornerRadius = 14
    }
    
    private func configureConstraints() {
        let padding: CGFloat = 10
        if let titleLabel = self.titleLabel {
            addSubview(titleLabel)
            titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, x: centerXAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: 0, paddingRight: 0, width: 0, height: self.titleSize + 5)
            addSubview(messageLabel)
            messageLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, x: centerXAnchor, paddingTop: 0, paddingLeft: padding, paddingBottom: padding, paddingRight: 0, width: 0, height: 0)
        } else {
            addSubview(messageLabel)
            messageLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, x: centerXAnchor, y: centerYAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: 0, width: 0, height: 0)
        }
    }
}
