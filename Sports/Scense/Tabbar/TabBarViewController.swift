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
        setupViewControllers()
        replaceTabBar()
        selectedIndex = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        let centerButton = UIButton(type: .custom)
        centerButton.backgroundColor = .accent
        centerButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        centerButton.frame.size = CGSize(width: 45, height: 45)
        centerButton.center = tabBar.center
        centerButton.center.y = tabBar.bounds.minY + 26
        centerButton.layer.cornerRadius = centerButton.frame.height / 2
        centerButton.clipsToBounds = true
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        tabBar.addSubview(centerButton)
    }
    
    @objc func centerButtonTapped() {
        print("Center button tapped")
    }
    
    private func setupViewControllers() {
        let homeViewController = HomeConfigurator.viewController(input: .init())
        let LiveViewController = LiveConfigurator.viewController(input: .init())
        let newsViewController = NewsConfigurator.viewController(input: .init())
        let settingsViewController = SettingsConfigurator.viewController(input: .init())
        
        let homeNavController = CustomNavigationController(rootViewController: homeViewController)
        let LiveNavController = CustomNavigationController(rootViewController: LiveViewController)
        let newsNavController = CustomNavigationController(rootViewController: newsViewController)
        let settingsNavController = CustomNavigationController(rootViewController: settingsViewController)
        
        // Create tab bar items
        homeNavController.tabBarItem = UITabBarItem(title: "Home".localized, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        LiveNavController.tabBarItem = UITabBarItem(title: "Live".localized, image: UIImage(systemName: "livephoto"), selectedImage: UIImage(systemName: "livephoto.play"))
        newsNavController.tabBarItem = UITabBarItem(title: "News".localized, image: UIImage(systemName: "newspaper.circle"), selectedImage: UIImage(systemName: "newspaper.circle.fill"))
        settingsNavController.tabBarItem = UITabBarItem(title: "Settings".localized, image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear.circle.fill"))
        
        // Assign view controllers to the tab bar controller
        self.viewControllers = [
            homeNavController,
            LiveNavController,
            newsNavController,
            settingsNavController
        ]
    }

    private func replaceTabBar() {
        let customTabBar = CustomTabBar()
        setValue(customTabBar, forKey: "tabBar")
    }
}

class CustomTabBar: UITabBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setupTabBarAppearance()

        guard let items = items else { return }
        _ = frame.width / CGFloat(items.count)
        let leftOffset: CGFloat = -25
        let rightOffset: CGFloat = 25

        for (index, item) in items.enumerated() {
            guard let itemView = item.value(forKey: "view") as? UIView else { continue }

            var frame = itemView.frame
            switch index {
            case 1: // Move the second item to the left
                frame.origin.x += leftOffset
            case 2: // Move the third item to the right
                frame.origin.x += rightOffset
            default:
                break
            }
            itemView.frame = frame
        }
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .regular)
        appearance.backgroundColor = .clear
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        itemAppearance.normal.iconColor = .lightGray
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.accent]
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        standardAppearance = appearance
        if #available(iOS 15.0, *) {
            scrollEdgeAppearance = appearance
        }
        tintColor = .accent
        unselectedItemTintColor = .label
        
        addCornerRadius(to: self, topLeft: 25, topRight: 25)
    }
    
    func addCornerRadius(to tabBar: UITabBar, topLeft: CGFloat, topRight: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: tabBar.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: topLeft, height: topRight))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        
        tabBar.layer.mask = maskLayer
        tabBar.layer.masksToBounds = true
        
        tabBar.layer.shadowColor = UIColor.label.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        tabBar.layer.shadowRadius = 2
        
    }
}
