//
//  HomeViewControllerFilterExtension.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfDateFilter ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dateFilterCell = collectionView.dequeueReusableCell(withReuseIdentifier: DateFilterCollectionViewCell.viewIdentifier(), for: indexPath) as? DateFilterCollectionViewCell else { return UICollectionViewCell() }
        presenter?.configureFilterCell(with: dateFilterCell, for: indexPath.item)
      
        return dateFilterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 4
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectDate(for: indexPath.item)
    }
}
