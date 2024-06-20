//
//  DateFilterCollectionViewLayout.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//

import UIKit

class DateFilterCollectionViewLayout: UICollectionViewFlowLayout {
   
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        
        let collectionViewSize = collectionView.bounds.size
        let proposedRect = CGRect(origin: proposedContentOffset, size: collectionViewSize)
        
        guard let layoutAttributes = layoutAttributesForElements(in: proposedRect) else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        
        let horizontalCenter = proposedContentOffset.x + collectionViewSize.width / 2
        
        var closestAttribute: UICollectionViewLayoutAttributes?
        for attributes in layoutAttributes {
            if closestAttribute == nil {
                closestAttribute = attributes
                continue
            }
            if abs(attributes.center.x - horizontalCenter) < abs(closestAttribute!.center.x - horizontalCenter) {
                closestAttribute = attributes
            }
        }
        
        guard let closest = closestAttribute else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        
        return CGPoint(x: closest.center.x - collectionViewSize.width / 2, y: proposedContentOffset.y)
    }
}

