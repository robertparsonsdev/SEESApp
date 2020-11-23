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
    
    init(textAlignment: NSTextAlignment, text: String) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.text = text
        configure()
    }
    
    private func configure() {
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        sizeToFit()
    }
}
