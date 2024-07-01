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
        configureRightBarButtonItems()
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.accent]
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
    
    // MARK: - Setup Right BarButton Items
    func configureRightBarButtonItems() {
        let notificationButton = UIBarButtonItem(image: .notificationIcon, style: .plain, target: self, action: #selector(notificationDidTap))
        notificationButton.tintColor = .white
        let searchButton = UIBarButtonItem(image: .searchIcon, style: .plain, target: self, action: #selector(searchDidTap))
        searchButton.tintColor = .white
        self.navigationItem.rightBarButtonItems = [notificationButton, searchButton]
    }
    
    @objc func searchDidTap() {
//        pushSearchView()
    }
    
    @objc func notificationDidTap() {
    }
    
    func pushSearchView() {
        if let viewController = UIStoryboard(name: "Search", bundle: .main).instantiateInitialViewController() {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
