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
        centerButton.tintColor = .background
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        tabBar.addSubview(centerButton)
    }
    
    @objc func centerButtonTapped() {
        let bottomSheetVC = BottomSheetConfigurator.viewController(input: .init())
        
        if let sheet = bottomSheetVC.sheetPresentationController {
            if #available(iOS 16.0, *) {
                let customDetent = BottomSheetDetent.custom(260).detent as! UISheetPresentationController.Detent
                sheet.detents = [customDetent]
            } else {
                let mediumDetent = BottomSheetDetent.medium.detent as! UISheetPresentationController.Detent
                sheet.detents = [mediumDetent]
            }
            
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        
        bottomSheetVC.modalPresentationStyle = .pageSheet
        present(bottomSheetVC, animated: true, completion: nil)
    }
    
    private func setupViewControllers() {
        let homeViewController = HomeConfigurator.viewController(input: .init())
        let matchesViewController = MatchesConfigurator.viewController(input: .init())
        let newsViewController = NewsConfigurator.viewController(input: .init())
        let momentsViewController = MomentsConfigurator.viewController(input: .init())
//        let settingsViewController = SettingsConfigurator.viewController(input: .init())
        
        let homeNavController = CustomNavigationController(rootViewController: homeViewController)
        let matchesNavController = CustomNavigationController(rootViewController: matchesViewController)
        let newsNavController = CustomNavigationController(rootViewController: newsViewController)
        let momentsNavController = CustomNavigationController(rootViewController: momentsViewController)

//        let settingsNavController = CustomNavigationController(rootViewController: settingsViewController)
        
        // Create tab bar items
        homeNavController.tabBarItem = UITabBarItem(title: "Home".localized, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        matchesNavController.tabBarItem = UITabBarItem(title: "Matches".localized, image: UIImage(systemName: "basketball"), selectedImage: UIImage(systemName: "basketball.fill"))
        
        newsNavController.tabBarItem = UITabBarItem(title: "News".localized, image: UIImage(systemName: "newspaper.circle"), selectedImage: UIImage(systemName: "newspaper.circle.fill"))
        
        momentsNavController.tabBarItem = UITabBarItem(title: "Moments".localized, image: UIImage(systemName: "video.circle"), selectedImage: UIImage(systemName: "video.circle.fill"))
        
        // Assign view controllers to the tab bar controller
        self.viewControllers = [
            homeNavController,
            matchesNavController,
            newsNavController,
            momentsNavController
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
        appearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
        appearance.backgroundColor = .clear
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        itemAppearance.normal.iconColor = .darkGray
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
