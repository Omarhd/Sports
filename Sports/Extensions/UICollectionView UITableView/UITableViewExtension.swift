//
//  UITableViewExtension.swift
//  Sports
//
//  Created by ios Dev on 10/05/2024.
//

import UIKit

extension UICollectionView {
    
    func setupCollectionView(viewController: UIViewController) {
        self.delegate = viewController as? UICollectionViewDelegate
        self.dataSource = viewController as? UICollectionViewDataSource
        self.contentInset = .zero
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
    
    func registerCell<Cell: UICollectionViewCell>(cell: Cell.Type) {
        let nibName = String(describing: cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}


extension UITableView {
    
    func setupTableView(viewController: UIViewController) {
        self.delegate        = viewController as? any UITableViewDelegate
        self.dataSource      = viewController as? any UITableViewDataSource
        self.tableFooterView = UIView()
        self.separatorInset  = .zero
        self.contentInset    = .zero
        self.separatorStyle  = .none
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator   = false
    }
    
    func registerCell<Cell : UITableViewCell>(cell : Cell.Type) {
        let nibName = String(describing: cell.self) // transform classCellName to String
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
}

