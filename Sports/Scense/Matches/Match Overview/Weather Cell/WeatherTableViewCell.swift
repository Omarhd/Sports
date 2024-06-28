//
//  WeatherTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 25/06/2024.
//

import UIKit

class WeatherTableViewCell: UITableViewCell, WeatherCellCellProtocol {

    // MARK: - Outlets
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellUI(weather: Weather?) {
        statusLabel.text = weather?.desc
        tempLabel.text = weather?.temp?.description
        windSpeedLabel.text = weather?.wind?.description
        humidityLabel.text = weather?.humidity?.description
        pressureLabel.text = weather?.pressure?.description
    }
    
}
