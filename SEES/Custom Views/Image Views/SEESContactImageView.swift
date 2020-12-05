//
//  SEESLogoImageView.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit

class SEESContactImageView: UIView {
    private var contact: ContactImage = .logo
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    convenience init(cornerRadius: CGFloat, contact: ContactImage) {
        self.init(frame: .zero)
        
        set(cornerRadius: cornerRadius, contact: contact)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(cornerRadius: CGFloat, contact: ContactImage) {
        self.layer.cornerRadius = cornerRadius
        self.contact = contact
        self.imageView.contentMode = .scaleAspectFit
        
        if !self.subviews.contains(self.imageView) {
            configureConstraints()
        }

        switch self.contact {
        case .logo:
            self.imageView.image = UIImage(named: "sees_logo")!
        case .alas:
            self.imageView.image = UIImage(named: "alas")!
        case .dora:
            self.imageView.image = UIImage(named: "dora")!
        }
    }
    
    private func configureView() {
        backgroundColor = .white
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    private func configureConstraints() {
        let radius = self.layer.cornerRadius
        
        addSubview(imageView)
        imageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, x: centerXAnchor, y: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: radius * 2 + 5, height: radius * 2 + 5)
        
        if self.contact == .logo {
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: radius / 9.75).isActive = true
        }
    }
}
