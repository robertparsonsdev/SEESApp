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
    private var padding: CGFloat = 10
    public var svDay: SVDay {
        get {
            if let text = self.titleLabel?.text { return SVDay(rawValue: text) ?? .monday }
            return .monday
        }
        set (newDay) {
            self.titleLabel?.text = newDay.rawValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureStackView()
    }
    
    convenience init(title: String = "", titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String = "", messageAlignment: NSTextAlignment = .center, frame: CGRect = .zero, padding: CGFloat = 10) {
        self.init(frame: frame)
        
        set(title: title, titleSize: titleSize, titleAlignment: titleAlignment, message: message, messageAlignment: messageAlignment, padding: padding)
    }
    
    convenience init(message: String = "", messageAlignment: NSTextAlignment = .center, frame: CGRect = .zero, padding: CGFloat = 10) {
        self.init(frame: frame)
        
        set(message: message, messageAlignment: messageAlignment, padding: padding)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(title: String, titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String, messageAlignment: NSTextAlignment = .center, padding: CGFloat = 10) {
        self.padding = padding
        self.titleLabel = SEESTitleLabel(textAlignment: titleAlignment, text: title, fontSize: titleSize)
        self.messageLabel.set(textAlignment: messageAlignment, text: message)
        
        configureConstraints()
    }
    
    public func set(message: String, messageAlignment: NSTextAlignment = .center, padding: CGFloat = 10) {
        self.padding = padding
        self.messageLabel.set(textAlignment: messageAlignment, text: message)
        
        configureConstraints()
    }
    
    public func set(attributedMessage: NSAttributedString, messageAlignment: NSTextAlignment, padding: CGFloat = 10) {
        self.padding = padding
        self.messageLabel.set(attributedText: attributedMessage, alignment: messageAlignment)
        
        configureConstraints()
    }
    
    public func set(messageFontSize: CGFloat) {
        self.messageLabel.set(fontSize: messageFontSize)
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
        guard !self.stackView.arrangedSubviews.contains(self.scrollView) else { return }
        
        var titleHeight: CGFloat = 0
        if let titleLabel = self.titleLabel {
            titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            stackView.addArrangedSubview(titleLabel)
            titleHeight = titleLabel.frame.height
        }
        
        let size = messageLabel.sizeThatFits(CGSize(width: self.frame.width - (self.padding * 2), height: self.frame.height - (self.padding * 2) - titleHeight))
        scrollView.contentSize = size
        scrollView.setContentHuggingPriority(.defaultLow, for: .vertical)
        stackView.addArrangedSubview(scrollView)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: self.padding, paddingLeft: self.padding, paddingBottom: self.padding, paddingRight: self.padding, width: 0, height: 0)
        scrollView.addSubviews(messageLabel)
        messageLabel.anchor(top: scrollView.topAnchor, leading: stackView.leadingAnchor, bottom: stackView.bottomAnchor, trailing: stackView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
