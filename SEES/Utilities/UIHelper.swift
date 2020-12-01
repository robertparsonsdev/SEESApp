//
//  UIHelper.swift
//  SEES
//
//  Created by Robert Parsons on 11/18/20.
//

import UIKit

struct UIHelper {
    static func createSingleColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 20
        let availableWidth = width - (padding * 2)
        let itemWidth = availableWidth
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: Dimensions.homeCellHeight)
        flowLayout.minimumLineSpacing = 15
        return flowLayout
    }
}
