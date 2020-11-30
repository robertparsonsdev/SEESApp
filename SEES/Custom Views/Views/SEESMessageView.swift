//
//  SEESMessageView.swift
//  SEES
//
//  Created by Robert Parsons on 11/22/20.
//

import UIKit

class SEESMessageView: UIView {
    private let stackView = UIStackView()
    private var titleLabel: SEESTitleLabel?
    private let messageLabel = SEESBodyLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureView()
        configureStackView()
    }
    
    convenience init(title: String, titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String, messageAlignment: NSTextAlignment = .center) {
        self.init(frame: .zero)
        
        set(title: title, titleSize: titleSize, titleAlignment: titleAlignment, message: message, messageAlignment: messageAlignment)
    }
    
    convenience init(message: String, messageAlignment: NSTextAlignment = .center) {
        self.init(frame: .zero)
        
        set(message: message, messageAlignment: messageAlignment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(title: String, titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String, messageAlignment: NSTextAlignment = .center) {
        self.titleLabel = SEESTitleLabel(textAlignment: titleAlignment, text: title, fontSize: titleSize)
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
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fill
    }
    
    private func configureConstraints() {
        let externalPadding: CGFloat = 10
        
        if let titleLabel = self.titleLabel {
            titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            stackView.addArrangedSubview(titleLabel)
        }
        self.messageLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        stackView.addArrangedSubview(self.messageLabel)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: externalPadding, paddingLeft: externalPadding, paddingBottom: externalPadding, paddingRight: externalPadding, width: 0, height: 0)
    }
}
