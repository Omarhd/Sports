//
//  TournamentHeaderTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//

import UIKit

protocol TournamentHeaderViewDelegate {
    func didCollapseCells(isCollapsed: Bool, section: Int)
}

class TournamentHeaderTableViewCell: UITableViewCell, TournamentHeaderCellProtocol {
  
    var isCollapsed: Bool = false
    var section: Int = 0

    var delegate: TournamentHeaderViewDelegate?
    
    @IBOutlet weak var matchesCountLabel: UILabel!
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var shrinkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTournamentCellUI(title: String?, sectionIndex: Int) {
        titleHeaderLabel.text = title
        section = sectionIndex
        shrinkButton.setImage(isCollapsed ? (UIImage(systemName: "chevron.up.circle.fill")) : (UIImage(systemName: "chevron.forward.circle.fill")), for: .normal)
    }
    
    @IBAction func shrinkCellsAction(_ sender: Any) {
        isCollapsed.toggle()
        delegate?.didCollapseCells(isCollapsed: isCollapsed, section: section)
    }
}
