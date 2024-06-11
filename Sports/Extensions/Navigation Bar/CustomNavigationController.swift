//
//  CustomNavigationController.swift
//  Sports
//
//  Created by ios Dev on 24/05/2024.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
    }
    
    private func setupNavigationBarAppearance() {
        // Standard appearance with a blur effect
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundEffect = UIBlurEffect(style: .regular)
        
        // Scroll edge appearance (blur effect when scrolling)
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.backgroundEffect = UIBlurEffect(style: .regular)
        
        // Apply the appearance to the navigation bar
        navigationBar.standardAppearance = standardAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationBar.compactAppearance = standardAppearance
        navigationBar.tintColor = .label // Color of bar button items
    }
}
