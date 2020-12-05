//
//  ContactCell.swift
//  SEES
//
//  Created by Robert Parsons on 12/4/20.
//

import UIKit

class ContactCell: UICollectionViewCell {
    static let identifier = "contactUsCellIdentifier"
    private let contactImageDimensions: CGFloat = 45
    
    private var contact: Contact!
    private weak var delegate: ContactCellDelegate!
    
    private var contactImage: SEESContactImageView! // refactor this
    private let contactNameLabel = SEESTitleLabel()
    private let contactSubLabel = SEESBodyLabel()
    
    private lazy var callButton: SEESButton = {
        let button = SEESButton(backgroundColor: .systemGreen, title: "")
        button.setAttributedTitle(configureButton(withTitle: "Call", andSymbol: Symbol.phone), for: .normal)
        button.addTarget(self, action: #selector(self.callButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var emailButton: SEESButton = {
        let button = SEESButton(backgroundColor: .systemBlue, title: "")
        button.setAttributedTitle(configureButton(withTitle: "Email", andSymbol: Symbol.envelope), for: .normal)
        button.addTarget(self, action: #selector(self.emailButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration Functions
    private func configureCell() {
        backgroundColor = .tertiarySystemFill
        layer.cornerRadius = 14
    }
    
    private func configureButton(withTitle title: String, andSymbol symbol: UIImage) -> NSMutableAttributedString {
        let attributedTitle = NSMutableAttributedString()
        let symbolAttachment = NSTextAttachment(image: symbol)
        attributedTitle.append(NSAttributedString(attachment: symbolAttachment))
        attributedTitle.append(NSAttributedString(string: " \(title)"))
        return attributedTitle
    }
    
    private func configureConstraints() {
        let internalPadding: CGFloat = 15
        let buttonWidth = frame.width / 2 - (internalPadding * 1.5), buttonHeight: CGFloat = 40
        
        addSubviews(contactImage, contactNameLabel, contactSubLabel, callButton, emailButton)
        contactImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: internalPadding, paddingLeft: internalPadding, paddingBottom: 0, paddingRight: 0, width: self.contactImageDimensions, height: self.contactImageDimensions)
        contactNameLabel.anchor(top: contactImage.topAnchor, leading: contactImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeft: internalPadding, paddingBottom: 0, paddingRight: internalPadding, width: 0, height: 0)
        contactSubLabel.anchor(top: contactNameLabel.bottomAnchor, leading: contactImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeft: internalPadding, paddingBottom: 0, paddingRight: internalPadding, width: 0, height: 0)
        
        callButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeft: internalPadding, paddingBottom: internalPadding, paddingRight: 0, width: buttonWidth, height: buttonHeight)
        emailButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: internalPadding, paddingRight: internalPadding, width: buttonWidth, height: buttonHeight)
    }
    
    // MARK: - Functions
    public func set(contact: Contact, delegate: ContactCellDelegate) {
        self.contact = contact
        self.delegate = delegate
        
        contactImage = SEESContactImageView(cornerRadius: self.contactImageDimensions / 2, contact: contact.image)
        contactNameLabel.set(textAlignment: .left, text: contact.name)
        contactSubLabel.set(textAlignment: .left, text: "\(contact.title), \(contact.office)")
        
        configureConstraints()
    }
    
    // MARK: - Selectors
    @objc private func callButtonTapped() {
        self.delegate.callButtonTapped(withNumber: self.contact.phone)
    }
    
    @objc private func emailButtonTapped() {
        self.delegate.emailButtonTapped(withEmail: self.contact.email)
    }
}

// MARK: - Protocols
protocol ContactCellDelegate: class {
    func callButtonTapped(withNumber number: String)
    func emailButtonTapped(withEmail email: String)
}
