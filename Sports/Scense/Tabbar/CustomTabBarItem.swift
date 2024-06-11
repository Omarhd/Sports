//
//  CustomTabBarItem.swift
//  Sports
//
//  Created by ios Dev on 23/05/2024.
//

import UIKit

class CustomTabBarItem: UITabBarItem {

    var iconView: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()

        iconView = UIImageView(image: UIImage(named: "unselected_icon"))
        iconView?.contentMode = .center
    }

    override var image: UIImage? {
        didSet {
            iconView?.image = image
        }
    }

    override var selectedImage: UIImage? {
        didSet {
            iconView?.image = selectedImage
        }
    }
}
