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
    
    func setupNavigationBarAppearance() {
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
        navigationBar.tintColor = .accent // Color of bar button items
    }
    
    // MARK: - Transparent Navigation Bar for Specific Child View Controller
    func setTransparentNavigationBar(for viewController: UIViewController) {
        let transparentAppearance = UINavigationBarAppearance()
        transparentAppearance.configureWithTransparentBackground()
        transparentAppearance.backgroundColor = .clear
        
        viewController.navigationItem.standardAppearance = transparentAppearance
        viewController.navigationItem.scrollEdgeAppearance = transparentAppearance
        viewController.navigationItem.compactAppearance = transparentAppearance
        
        navigationController?.navigationBar.standardAppearance = transparentAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = transparentAppearance
        navigationController?.navigationBar.compactAppearance = transparentAppearance
        
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    func setClearNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.accent]
        appearance.backgroundColor = UIColor.clear

        navigationController?.navigationBar.tintColor = .accent
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        appearance.shadowColor = .clear
        
        navigationItem.standardAppearance = appearance

        // Scroll edge appearance (blur effect when scrolling)
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        
        // Apply the appearance to the navigation bar
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = .accent // Color of bar button items
    }

}
