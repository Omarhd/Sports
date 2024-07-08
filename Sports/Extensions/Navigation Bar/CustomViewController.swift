//
//  CustomViewController.swift
//  Sports
//
//  Created by ios Dev on 08/07/2024.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureRightBarButtonItems()
    }
    
    // MARK: - Setup Right BarButton Items
    func configureRightBarButtonItems() {
        let notificationButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(notificationDidTap))
        notificationButton.tintColor = .label
        let settings = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsDidTap))
        settings.tintColor = .label
        self.navigationItem.rightBarButtonItems = [notificationButton, settings]
        self.navigationItem.backButtonTitle = " "
    }
    
    @objc func settingsDidTap() {
        // Handle search button tap
    }
    
    @objc func notificationDidTap() {
        // Handle notification button tap
    }
}
