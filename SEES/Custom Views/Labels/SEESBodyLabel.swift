//
//  SEESBodyLabel.swift
//  SEES
//
//  Created by Robert Parsons on 11/15/20.
//

import UIKit

class SEESBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment = .center, text: String) {
        self.init(frame: .zero)
        
        set(textAlignment: textAlignment, text: text)
    }
    
    public func set(textAlignment: NSTextAlignment = .center, text: String) {
        self.textAlignment = textAlignment
        self.text = text
    }
    
    public func set(attributedText: NSAttributedString, alignment: NSTextAlignment = .center) {
        self.textAlignment = alignment
        self.attributedText = attributedText
    }
    
    public func set(fontSize: CGFloat) {
        font = UIFont.systemFont(ofSize: fontSize)
    }
    
    private func configure() {
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
    }
}
