//
//  HighlightMomentTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 28/06/2024.
//

import UIKit

class HighlightMomentTableViewCell: UITableViewCell, HighlightMomentCellProtocol {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
   
    // MARK: - Properties
    var moments: [MomentsEntity] = []
    weak var delegate: MomentsCollectionCellViewControllerProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with moments: [MomentsEntity]) {
        self.moments = moments
        collectionView.registerCell(cell: HighlightMomentCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension HighlightMomentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moments.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HighlightMomentCollectionViewCell.viewIdentifier(), for: indexPath) as? HighlightMomentCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(with: moments[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2.2), height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 6, bottom: 6, right: 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTappedMoment(with: moments[indexPath.item], allMoments: moments)
    }
    
}
