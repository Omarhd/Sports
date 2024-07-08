//
//  CustomViewController.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//

import UIKit

extension UIViewController {
    
    func setTransparentNavigationBar() {
        if let customNavigationController = navigationController as? CustomNavigationController {
            customNavigationController.setTransparentNavigationBar(for: self)
        }
    }
    
    func restoreDefaultNavigationBar() {
        if let customNavigationController = navigationController as? CustomNavigationController {
            customNavigationController.setupNavigationBarAppearance()
        }
    }
}
