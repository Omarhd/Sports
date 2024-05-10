//
//  HomeViewControllerExtensions.swift
//  Sports
//
//  Created by ios Dev on 10/05/2024.
//

import UIKit
import SkeletonView

extension HomeViewController: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return TournamentTableViewCell.viewIdentifier()
    }

    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
