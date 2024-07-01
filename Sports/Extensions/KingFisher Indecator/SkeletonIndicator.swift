//
//  SkeletonIndicator.swift
//  Sports
//
//  Created by ios Dev on 29/06/2024.
//

import Kingfisher

class SkeletonIndicator: Indicator {
    var view: IndicatorView
    var isAnimating: Bool = false
    
    init() {
        self.view = SkeletonView()
    }
    
    func startAnimatingView() {
        guard let skeletonView = view as? SkeletonView else { return }
        skeletonView.startAnimating()
        isAnimating = true
    }
    
    func stopAnimatingView() {
        guard let skeletonView = view as? SkeletonView else { return }
        skeletonView.stopAnimating()
        isAnimating = false
    }
}
