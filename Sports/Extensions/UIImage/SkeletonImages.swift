//
//  SkeletonImages.swift
//  Sports
//
//  Created by ios Dev on 22/06/2024.
//

import UIKit
import Kingfisher
import SkeletonView

extension UIImageView {

    func setImageWithSkeleton(with url: URL?, placeholder: UIImage? = UIImage(systemName: "basketball.fill")) {
        self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray,
                                                               secondaryColor: .accent),
                                          animation: nil,
                                          transition: .crossDissolve(0.25))
        
        self.kf.setImage(with: url, placeholder: placeholder, options: nil, progressBlock: nil) { result in
            DispatchQueue.main.async {
                self.hideSkeleton(transition: .crossDissolve(0.25))
            }
        }
    }
}
