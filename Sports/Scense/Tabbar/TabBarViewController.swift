//
//  TabBarViewController.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupViewControllers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setupViewControllers() {
        let homeViewController = HomeConfigurator.viewController(input: .init())
        let socialMediaViewController = SocialMediaConfigurator.viewController(input: .init())
        let newsViewController = NewsConfigurator.viewController(input: .init())
        let settingsViewController = SettingsConfigurator.viewController(input: .init())
        
        let homeNavController = CustomNavigationController(rootViewController: homeViewController)
        let socialMediaNavController = CustomNavigationController(rootViewController: socialMediaViewController)
        let newsNavController = CustomNavigationController(rootViewController: newsViewController)
        let settingsNavController = CustomNavigationController(rootViewController: settingsViewController)
        
        // Create tab bar items
        homeNavController.tabBarItem = UITabBarItem(title: "Home".localized, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        socialMediaNavController.tabBarItem = UITabBarItem(title: "Social".localized, image: UIImage(systemName: "link.circle"), selectedImage: UIImage(systemName: "link.circle.fill"))
        newsNavController.tabBarItem = UITabBarItem(title: "News".localized, image: UIImage(systemName: "newspaper.circle"), selectedImage: UIImage(systemName: "newspaper.circle.fill"))
        settingsNavController.tabBarItem = UITabBarItem(title: "Settings".localized, image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear.circle.fill"))
        
        // Assign view controllers to the tab bar controller
        self.viewControllers = [
            homeNavController,
            socialMediaNavController,
            newsNavController,
            settingsNavController
        ]
    }
    
    private func setupTabBarAppearance() {
        // Create a blur effect for the tab bar background
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .regular)
        appearance.backgroundColor = .clear // Set the background color to clear to apply the blur effect
        
        // Customize the item appearance
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.accent]
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        // Apply the appearance to the tab bar
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        tabBar.tintColor = .accent // Color of selected tab bar items
        tabBar.unselectedItemTintColor = .darkGray // Color of unselected tab bar items
    }
    
}
