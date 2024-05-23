//
//  UIViewCornerRadius.swift
//  Sports
//
//  Created by ios Dev on 22/05/2024.
//

import UIKit

@IBDesignable
class RoundedCornerView: UIView {

    // Inspectable properties for each corner radius
    @IBInspectable var topLeftRadius: CGFloat = 0 {
        didSet {
            updateCorners()
        }
    }
    @IBInspectable var topRightRadius: CGFloat = 0 {
        didSet {
            updateCorners()
        }
    }
    @IBInspectable var bottomLeftRadius: CGFloat = 0 {
        didSet {
            updateCorners()
        }
    }
    @IBInspectable var bottomRightRadius: CGFloat = 0 {
        didSet {
            updateCorners()
        }
    }

    // Update the corners when any radius changes
    private func updateCorners() {
        // Define the corners to be rounded
        var corners: UIRectCorner = []
        if topLeftRadius > 0 {
            corners.insert(.topLeft)
        }
        if topRightRadius > 0 {
            corners.insert(.topRight)
        }
        if bottomLeftRadius > 0 {
            corners.insert(.bottomLeft)
        }
        if bottomRightRadius > 0 {
            corners.insert(.bottomRight)
        }

        // Create the path with the specified rounded corners
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: topLeftRadius, height: topLeftRadius))

        // Create a shape layer with this path
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        // Apply the mask to the view's layer
        self.layer.mask = mask
    }

    // Ensure the corners are updated when the view's layout changes
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCorners()
    }
}
