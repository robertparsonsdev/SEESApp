//
//  SEESMessageView.swift
//  SEES
//
//  Created by Robert Parsons on 11/22/20.
//

import UIKit

class SEESMessageView: UIView {
    private var titleSize: CGFloat = 20
    private var titleLabel: SEESTitleLabel? = SEESTitleLabel()
    private let messageLabel = SEESBodyLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureView()
    }
    
    init(title: String?, titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String, messageAlignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        
        configureView()
        set(title: title, titleSize: titleSize, titleAlignment: titleAlignment, message: message, messageAlignment: messageAlignment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(title: String?, titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String, messageAlignment: NSTextAlignment = .center) {
        self.titleSize = titleSize
        
        if let text = title {
            self.titleLabel?.set(textAlignment: titleAlignment, text: text, fontSize: titleSize)
        } else {
            self.titleLabel = nil
        }
        self.messageLabel.set(textAlignment: messageAlignment, text: message)
        
        removeLabelsFromSuperview()
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
            titleLabel.backgroundColor = .systemPink
            addSubview(titleLabel)
            titleLabel.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, x: centerXAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: 0, paddingRight: padding, width: 0, height: self.titleSize + 5)
            addSubview(messageLabel)
            messageLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, x: centerXAnchor, paddingTop: 0, paddingLeft: padding, paddingBottom: padding, paddingRight: padding, width: 0, height: 0)
        } else {
            addSubview(messageLabel)
            messageLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: leadingAnchor, x: centerXAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding, width: 0, height: 0)
        }
    }
    
    private func removeLabelsFromSuperview() {
        self.titleLabel?.removeFromSuperview()
        self.messageLabel.removeFromSuperview()
    }
}
