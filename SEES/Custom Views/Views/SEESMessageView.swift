//
//  SEESMessageView.swift
//  SEES
//
//  Created by Robert Parsons on 11/22/20.
//

import UIKit

class SEESMessageView: UIView {
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    private var titleLabel: SEESTitleLabel?
    private let messageLabel = SEESBodyLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureStackView()
    }
    
    convenience init(title: String, titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String, messageAlignment: NSTextAlignment = .center, frame: CGRect) {
        self.init(frame: frame)
        
        set(title: title, titleSize: titleSize, titleAlignment: titleAlignment, message: message, messageAlignment: messageAlignment)
    }
    
    convenience init(message: String, messageAlignment: NSTextAlignment = .center, frame: CGRect) {
        self.init(frame: frame)
        
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
    
    public func set(attributedMessage: NSAttributedString, messageAlignment: NSTextAlignment) {
        self.messageLabel.set(attributedText: attributedMessage, alignment: messageAlignment)
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
        guard !self.stackView.arrangedSubviews.contains(self.messageLabel) else { return }
        let externalPadding: CGFloat = 10
        
        var titleHeight: CGFloat = 0
        if let titleLabel = self.titleLabel {
            titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            stackView.addArrangedSubview(titleLabel)
            titleHeight = titleLabel.frame.height
        }
        
        let size = messageLabel.sizeThatFits(CGSize(width: self.frame.width - (externalPadding * 2), height: self.frame.height - (externalPadding * 2) - titleHeight))
        scrollView.contentSize = size
        scrollView.setContentHuggingPriority(.defaultLow, for: .vertical)
        stackView.addArrangedSubview(scrollView)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: externalPadding, paddingLeft: externalPadding, paddingBottom: externalPadding, paddingRight: externalPadding, width: 0, height: 0)
        scrollView.addSubviews(messageLabel)
        messageLabel.anchor(top: scrollView.topAnchor, leading: stackView.leadingAnchor, bottom: stackView.bottomAnchor, trailing: stackView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
