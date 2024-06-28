//
//  CardView.swift
//  Sports
//
//  Created by ios Dev on 28/06/2024.
//

import UIKit

class CardView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Set the corner radius
        layer.cornerRadius = 16
        
        // Set the shadow properties
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
        
        // Ensure the view clips to its bounds, maintaining the corner radius and shadow
        layer.masksToBounds = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Update the shadow path to match the bounds of the view
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
