//
//  HotNewsTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 23/05/2024.
//

import UIKit

class HotNewsTableViewCell: UITableViewCell, HotNewsCellCellProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: HotNewsCellViewControllerProtocol?
    var news: [News] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCellUI(news: [News]?) {
        self.news = news ?? []
        collectionView.registerCell(cell: HotNewsCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension HotNewsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotNewsCollectionViewCell.viewIdentifier(), for: indexPath) as? HotNewsCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(with: news[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 16, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectNews(indexPath: indexPath)
    }
}
