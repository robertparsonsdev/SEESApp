//
//  SEESLogoImageView.swift
//  SEES
//
//  Created by Robert Parsons on 11/13/20.
//

import UIKit

class SEESLogoImageView: UIView {
    private let imageView = UIImageView()
    private var radius: CGFloat = 0
    
    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        self.radius = cornerRadius
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configure() {
        backgroundColor = .white
        layer.masksToBounds = true
        clipsToBounds = true
        layer.cornerRadius = self.radius
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "sees_logo")!
        
        addSubview(imageView)
        imageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, x: centerXAnchor, y: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.radius * 2, height: self.radius * 2)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: radius / 9.75).isActive = true
    }
}
