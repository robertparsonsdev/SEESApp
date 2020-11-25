//
//  SEESTitleLabel.swift
//  SEES
//
//  Created by Robert Parsons on 11/18/20.
//

import UIKit

class SEESTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, text: String, fontSize: CGFloat) {
        self.init(frame: .zero)
        
        set(textAlignment: textAlignment, text: text, fontSize: fontSize)
    }
    
    public func set(textAlignment: NSTextAlignment, text: String, fontSize: CGFloat) {
        self.textAlignment = textAlignment
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        numberOfLines = 2
    }
}
