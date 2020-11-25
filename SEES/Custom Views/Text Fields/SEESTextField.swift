//
//  SEESTextField.swift
//  SEES
//
//  Created by Robert Parsons on 11/14/20.
//

import UIKit

class SEESTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String, keyboardType: UIKeyboardType, returnKeyType: UIReturnKeyType) {
        self.init(frame: .zero)
        
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
    }
    
    func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 0
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .headline)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemFill
        autocapitalizationType = .none
        autocorrectionType = .no
    }
}
