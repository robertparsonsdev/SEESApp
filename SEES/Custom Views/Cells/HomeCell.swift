//
//  HomeCell.swift
//  SEES
//
//  Created by Robert Parsons on 11/18/20.
//

import UIKit

class HomeCell: UICollectionViewCell {
    public static let identifier = "HomeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureCell() {
        layer.cornerRadius = 14
        backgroundColor = .systemBlue
    }
}
