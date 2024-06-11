//
//  TournamentDetailsViewController.swift
//  Sports
//
//  Created by ios Dev on 13/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class TournamentDetailsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
    // MARK: Outlets
    
    // MARK: Properties
    var presenter: TournamentDetailsPresenterProtocol?
   
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        setupCollectionViewLayout()
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let padding: CGFloat = 16
            layout.minimumLineSpacing = 40
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }

        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(TournamentDetailsCollectionViewCell.self, forCellWithReuseIdentifier: TournamentDetailsCollectionViewCell.viewIdentifier())
        collectionView.register(TournamentHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TournamentHeaderCollectionReusableView.viewIdentifier())
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TournamentHeaderCollectionReusableView.viewIdentifier(), for: indexPath) as? TournamentHeaderCollectionReusableView else { return UICollectionReusableView()}
        header.configureHeaderUI()
        guard let headerImageUrl = URL(string:presenter?.configureHeader() ?? "") else { return UICollectionReusableView() }
        header.headerImageView.kf.setImage(with: headerImageUrl)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 200)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TournamentDetailsCollectionViewCell.viewIdentifier(), for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * 16, height: 100)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? TournamentHeaderCollectionReusableView else { return }
        
        let offsetY = scrollView.contentOffset.y
        if offsetY > 0 {
            let alpha = min(1, offsetY / 100) // Adjust the divisor to change the speed of blur alpha change
            header.blurEffectView.alpha = alpha
        } else {
            header.blurEffectView.alpha = 0
        }
    }
    
}

extension TournamentDetailsViewController: TournamentDetailsControllerProtocol {
    
    func configureHeader(with header: String) {
        
    }

    func setTournamentDetails(tournamentDetails: Tournament) {
        print(tournamentDetails)
    }
}

