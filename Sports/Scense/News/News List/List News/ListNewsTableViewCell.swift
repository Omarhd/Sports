//
//  ListNewsTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 06/06/2024.
//

import UIKit
import Kingfisher

class ListNewsTableViewCell: UITableViewCell, NewsCellCellProtocol {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellUI(news: News?) {
        guard let imageUrl = URL(string: news?.path ?? "") else { return }
        newsImage.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "newspaper"))
        
        newsTitleLabel.text = news?.title
        newsDescriptionLabel.text = news?.description
    }
}
