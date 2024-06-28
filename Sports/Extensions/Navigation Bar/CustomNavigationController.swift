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
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.backgroundColor = UIColor.background

        navigationController?.navigationBar.tintColor = .accent
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        appearance.shadowColor = .clear
        
        navigationItem.standardAppearance = appearance

        // Scroll edge appearance (blur effect when scrolling)
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.backgroundEffect = UIBlurEffect(style: .regular)
        
        // Apply the appearance to the navigation bar
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = .label // Color of bar button items
    }
}
