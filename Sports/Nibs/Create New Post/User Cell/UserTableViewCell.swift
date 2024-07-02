//
//  UserTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 02/07/2024.
//

import UIKit

class UserTableViewCell: UITableViewCell, UserCellProtocol {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellUI(with user: User) {
        
    }
    
}
