//
//  HomeHeader.swift
//  SEES
//
//  Created by Robert Parsons on 11/18/20.
//

import UIKit

class HomeHeader: UICollectionReusableView {
    public static let identifer = "HomeHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureCell() {
        backgroundColor = .systemPurple
    }
}
