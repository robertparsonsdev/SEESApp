//
//  SEESMessageView.swift
//  SEES
//
//  Created by Robert Parsons on 11/22/20.
//

import UIKit

class SEESMessageView: UIView {
    private var labelWidth: CGFloat = 0
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
    
    convenience init(title: String, titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String, messageAlignment: NSTextAlignment = .center, dimensions: ScreenDimensions) {
        self.init(titleSize: titleSize)
        
        set(title: title, titleSize: titleSize, titleAlignment: titleAlignment, message: message, messageAlignment: messageAlignment, dimensions: dimensions)
    }
    
    convenience init(message: String, messageAlignment: NSTextAlignment = .center, dimensions: ScreenDimensions) {
        self.init(titleSize: nil)
        
        set(message: message, messageAlignment: messageAlignment, dimensions: dimensions)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(title: String, titleSize: CGFloat = 20, titleAlignment: NSTextAlignment = .center, message: String, messageAlignment: NSTextAlignment = .center, dimensions: ScreenDimensions) {
        self.titleLabel = SEESTitleLabel(textAlignment: titleAlignment, text: title, fontSize: self.titleSize)
        self.messageLabel.set(textAlignment: messageAlignment, text: message)
        self.labelWidth = dimensions.width
        configureConstraints()
    }
    
    public func set(message: String, messageAlignment: NSTextAlignment = .center, dimensions: ScreenDimensions) {
        self.messageLabel.set(textAlignment: messageAlignment, text: message)
        self.labelWidth = dimensions.width
        configureConstraints()
    }
    
    private func configureView() {
        backgroundColor = .tertiarySystemFill
        clipsToBounds = true
        layer.cornerRadius = 14
    }
    
    private func configureConstraints() {
        let padding: CGFloat = 10
        let topMessageConstraint: NSLayoutYAxisAnchor
        
        if let titleLabel = self.titleLabel {
            titleLabel.backgroundColor = .systemPink
            addSubview(titleLabel)
            titleLabel.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, x: centerXAnchor, paddingTop: padding, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.labelWidth, height: self.titleSize + 5)
            topMessageConstraint = titleLabel.bottomAnchor
        } else {
            topMessageConstraint = topAnchor
        }
        
        messageLabel.backgroundColor = .systemIndigo
        addSubview(messageLabel)
        messageLabel.anchor(top: topMessageConstraint, leading: nil, bottom: bottomAnchor, trailing: nil, x: centerXAnchor, y: nil, paddingTop: self.titleLabel == nil ? padding : 0, paddingLeft: 0, paddingBottom: padding, paddingRight: 0, width: self.labelWidth, height: 0)
    }
}
