//
//  MatchDetailsExtension.swift
//  Sports
//
//  Created by ios Dev on 22/06/2024.
//

import UIKit

extension MatchDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.allTabs.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let tabCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.viewIdentifier(), for: indexPath) as? TabCollectionViewCell else { return UICollectionViewCell() }
        presenter?.configureTabsCell(with: tabCell, for: indexPath.item)
        return tabCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 4
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectTab(for: indexPath.item)
    }
}
