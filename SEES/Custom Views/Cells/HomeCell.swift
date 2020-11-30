//
//  HomeCell.swift
//  SEES
//
//  Created by Robert Parsons on 11/18/20.
//

import UIKit

class HomeCell: UICollectionViewCell {
    public static let identifier = "HomeCell"
    
    private let imageView = UIImageView()
    private let titleLabel = SEESTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage, andText text: String) {
        self.imageView.image = image
        self.titleLabel.set(textAlignment: .center, text: text, fontSize: 32)
        self.titleLabel.textColor = .white
    }
    
    fileprivate func configureCell() {
        layer.cornerRadius = 14
        clipsToBounds = true
        let padding: CGFloat = 10
        
        addSubviews(imageView, titleLabel)
        
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: padding, paddingLeft: (padding * 2), paddingBottom: padding, paddingRight: padding, width: self.frame.height - (padding * 2), height: 0)
        titleLabel.anchor(top: topAnchor, leading: imageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: padding * 2, width: 0, height: 0)
    }
}
