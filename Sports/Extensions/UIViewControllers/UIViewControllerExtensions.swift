//
//  UIViewControllerExtensions.swift
//  Sports
//
//  Created by ios Dev on 10/05/2024.
//

import UIKit
import Kingfisher

extension UIViewController {
    
    // MARK: - func of load images wit kingfisher
    func loadImages(loadImage: UIImageView, from imagePathURL: String?) {
        if let imagePathURL = imagePathURL, let url = URL(string: imagePathURL) {
            loadImage.kf.indicatorType = .custom(indicator: SkeletonIndicator())
            loadImage.kf.setImage(with: url)
        } else {
            loadImage.image = UIImage(systemName: "basketball.fill")
        }
    }
    
    //MARK: - func setup empty case
    func setEmptyCase(imageName: String, title: String, message: String, tableViewData: UITableView? = nil, collectionViewData: UICollectionView? = nil, containerView: UIView) {
        deleteEmptyView()
        var emptyData = EmptyDataView()
        emptyData = EmptyDataView.init(frame: .zero)
        emptyData.setupViewConstraint(view: containerView)
        emptyData.setupView(imageName: imageName, title: title, message: message)
        tableViewData?.isHidden = true
        collectionViewData?.isHidden = true
    }
    
    //MARK: - Delete empty view
    func deleteEmptyView() {
        if let customEmptyView = self.view.viewWithTag(100) {
            customEmptyView.removeFromSuperview()
        }
    }
    
    //MARK: - Load Table View And Collection View
    func loadTableAndCollection(tableView: UITableView? = nil, collectionView: UICollectionView? = nil) {
        deleteEmptyView()
        tableView?.isHidden = false
        collectionView?.isHidden = false
        tableView?.reloadData()
        collectionView?.reloadData()
    }
    
}
