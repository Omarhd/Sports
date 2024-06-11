//
//  StretchyHeaderLayout.swift
//  Sports
//
//  Created by ios Dev on 05/06/2024.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
                
        layoutAttributes?.forEach({ attribute in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader && attribute.indexPath.section == 0 { // For header in 0 Section Only
                guard let collectionView = collectionView else { return }
                
                let contentOffsetY = collectionView.contentOffset.y
                if contentOffsetY > 0 { return }
                
                let width = attribute.frame.width
                let height = attribute.frame.height - contentOffsetY
                
                attribute.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
            }
        })
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
