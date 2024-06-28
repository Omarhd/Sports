//
//  DetailsPagesPresenter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class DetailsPagesPresenter: NSObject {
    // MARK: - Properties
    private var view: DetailsPagesControllerProtocol?
    private var interactor: DetailsPagesPresenterInteractorProtocol?
    private var router: DetailsPagesRouterProtocol?
    private weak var pageControllerDelegate: PageControllerViewDelegate?

    private var match: Match
    private var pages: [UIViewController] = []

    // MARK: - Init
    init(view: DetailsPagesControllerProtocol?,
         interactor: DetailsPagesPresenterInteractorProtocol?,
         router: DetailsPagesRouterProtocol?,
         pageControllerDelegate: PageControllerViewDelegate?,
         match: Match) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.pageControllerDelegate = pageControllerDelegate
        self.match = match
    }
}
// MARK: Conform to DetailsPagesPresenterProtocol
extension DetailsPagesPresenter: DetailsPagesPresenterProtocol {
    
    func viewDidLoad() {
        interactor?.fetchPages(with: self.match)
    }
}
// MARK: Conform to DetailsPagesInteractorOutput
extension DetailsPagesPresenter: DetailsPagesInteractorOutput {
    
    func didFetchPages(_ pages: [UIViewController]) {
        self.pages = pages
        view?.setChilds(viewController: pages)
    }
}

// MARK: - UIPageViewControllerDataSource
extension DetailsPagesPresenter: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else { return nil }

        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        guard nextIndex < pages.count else { return nil }
        
        return pages[nextIndex]
    }
    
    func scrollToPage(with index: Int, for pageViewController: UIPageViewController) {
        let indexPath = IndexPath(item: index, section: 0)
        
        let selectedViewController = pages[indexPath.item]
        if let currentIndex = pageViewController.viewControllers?.first.flatMap({ pages.firstIndex(of: $0) }) {
            let direction: UIPageViewController.NavigationDirection = indexPath.item > currentIndex ? .forward : .reverse
            pageViewController.setViewControllers([selectedViewController], direction: direction, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let currentViewController = pageViewController.viewControllers?.first else {
            return
        }
        
        if let index = pages.firstIndex(of: currentViewController) {
            let indexPath = IndexPath(item: index, section: 0)
            pageControllerDelegate?.updateCollectionIndex(with: indexPath.item)
        }
    }
}

