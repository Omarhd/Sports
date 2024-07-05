//
//  PublishTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 02/07/2024.
//

import UIKit

class PublishTableViewCell: UITableViewCell, PublishCellProtocol {

    // MARK: - Outlets
    @IBOutlet weak var publishButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: PublishCellDelegateProtocol?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellUI() {
        
    }
    
    @IBAction func publishAction(_ sender: Any) {
    }
    
}
