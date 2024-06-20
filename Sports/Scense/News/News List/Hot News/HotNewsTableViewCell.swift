//
//  HotNewsTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 23/05/2024.
//

import UIKit

class HotNewsTableViewCell: UITableViewCell, NewsCellCellProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        registerNIBs()
    }
    
    fileprivate func registerNIBs() {
        collectionView.register(HotNewsCollectionViewCell.self, forCellWithReuseIdentifier: HotNewsCollectionViewCell.viewIdentifier())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellUI(news: News?) {
        collectionView.reloadData()
    }
}

extension HotNewsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotNewsCollectionViewCell.viewIdentifier(), for: indexPath) as? HotNewsCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = randomColor()
        return cell
    }
}

func randomColor() -> UIColor {
    let colors: [UIColor] = [.accent, .red, .yellow, .red, .white, .black, . gray]
    return colors.randomElement()!
}
