//
//  DetailsPagesViewController.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class DetailsPagesViewController: UIPageViewController {
    
    // MARK: Outlets

    // MARK: Properties
    var presenter: DetailsPagesPresenterProtocol?
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        dataSource = presenter as? UIPageViewControllerDataSource
        delegate = presenter as? UIPageViewControllerDelegate
        NotificationCenter.default.addObserver(self, selector: #selector(handleTabIndexChange(notification:)), name: .selectedTabIndexChanged, object: nil)
    }
    
    
    @objc private func handleTabIndexChange(notification: Notification) {
        if let index = notification.userInfo?["selectedTabIndex"] as? Int {
            presenter?.scrollToPage(with: index, for: self)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .selectedTabIndexChanged, object: nil)
    }

}

extension DetailsPagesViewController: DetailsPagesControllerProtocol {
    
    func setChilds(viewController: [UIViewController]) {
        if let firstViewController = viewController.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

