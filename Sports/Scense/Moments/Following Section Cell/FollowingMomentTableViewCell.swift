//
//  FollowingMomentTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 28/06/2024.
//

import UIKit

class FollowingMomentTableViewCell: UITableViewCell, FollowingMomentCellProtocol {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var moments: [MomentsEntity] = []
    weak var delegate: MomentsCollectionCellViewControllerProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(with moments: [MomentsEntity]) {
        self.moments = moments
        collectionView.registerCell(cell: FollowingMomentCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension FollowingMomentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moments.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowingMomentCollectionViewCell.viewIdentifier(), for: indexPath) as? FollowingMomentCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(with: moments[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2.2), height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTappedMoment(with: moments[indexPath.item], allMoments: moments)
    }
    
}
