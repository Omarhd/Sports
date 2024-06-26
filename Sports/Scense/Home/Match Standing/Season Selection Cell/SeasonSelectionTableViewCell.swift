//
//  SeasonSelectionTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 26/06/2024.
//

import UIKit

class SeasonSelectionTableViewCell: UITableViewCell, SeasonSelectionProtocol {

    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var options: [SeasonSelection] = []
    var selectedOption: SeasonSelection = .short
    weak var delegate: SeasonSelectionTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with options: [SeasonSelection]) {
        self.options = options
        collectionView.registerCell(cell: TeamSelectionCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension SeasonSelectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamSelectionCollectionViewCell.viewIdentifier(), for: indexPath) as? TeamSelectionCollectionViewCell else { return UICollectionViewCell() }
        cell.isSelected = selectedOption.rawValue == indexPath.item
        cell.configureCell(with: options[indexPath.item].description)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 120
        let heigh = 60
        
        return CGSize(width: width, height: heigh)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectOption(with: SeasonSelection(rawValue: indexPath.item) ?? .short)
    }
    
}
