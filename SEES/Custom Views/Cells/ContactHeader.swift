//
//  ContactHeader.swift
//  SEES
//
//  Created by Robert Parsons on 12/5/20.
//

import UIKit

class ContactHeader: UICollectionReusableView {
    static let identifier = "contactUsHeaderIdentifier"
    
    private var messageView = SEESMessageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell() {
        self.backgroundColor = .systemBackground
        
        messageView.set(title: "The SEES Office is located at 3-2123 and is open Monday-Friday from 8:00 AM-5:00 PM.", message: "The SEES Quiet Room is open 24/7 and the SEES Community Room is open at 8:00 AM and closes when the last person leaves.")
        messageView.frame = frame
        
        addSubview(messageView)
        messageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 15, paddingRight: 20, width: 0, height: 0)
    }
}
