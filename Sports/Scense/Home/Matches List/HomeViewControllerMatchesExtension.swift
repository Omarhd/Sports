//
//  HomeViewControllerMatchesExtension.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//

import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, TournamentHeaderViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfMatches.count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let tournamentHeaderCell = tableView.dequeueReusableCell(withIdentifier: TournamentHeaderTableViewCell.viewIdentifier()) as? TournamentHeaderTableViewCell else { return UITableViewCell() }
        tournamentHeaderCell.delegate = self
        presenter?.configureTournamentHeaderCell(with: tournamentHeaderCell, for: section)
        return tournamentHeaderCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(for: section) ?? 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return presenter?.heightForSectionHeader ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let matchCell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.viewIdentifier(), for: indexPath) as? MatchTableViewCell else { return UITableViewCell() }
        presenter?.configureCell(with: matchCell, for: indexPath)
        return matchCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectMatch(for: indexPath)
    }
    
    func didCollapseCells(isCollapsed: Bool, section: Int) {
        presenter?.setSectionCollapse(isCollapsed: isCollapsed, for: section)
        tableView.reloadData()
    }
    
    func reloadSection(_ section: Int) {
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
