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
    func loadKingfisherImages(loadImage: UIImageView, imageURL: String) {
        loadImage.isHidden = false
        if imageURL == "" {
            loadImage.image = UIImage(systemName: "person.crop.circle.fill")
        }else{
            loadImage.kf.indicatorType = .activity
            let url = URL(string: imageURL)
            loadImage.kf.setImage(with: url)
        }
    }
    
    //MARK: - func setup empty case
    func setEmptyCase(imgName: String, title: String, message: String, tableViewData: UITableView? = nil, collectionViewData: UICollectionView? = nil, containerView: UIView) {
        deleteEmptyView()
        var emptyData = EmptyDataView()
        emptyData = EmptyDataView.init(frame: .zero)
        emptyData.setupViewConstraint(vu: containerView)
        emptyData.setupView(imageName: imgName, title: title, message: message)
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
