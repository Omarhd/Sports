//
//  MatchOddsTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 26/06/2024.
//

import UIKit

class MatchOddsTableViewCell: UITableViewCell, MatchOddsCellProtocol {

    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var homeTeamOddsLabel: UILabel!
    @IBOutlet weak var awayTeamOddLabel: UILabel!
    
    @IBOutlet weak var homeTeamOddAddedValueLabel: UILabel!
    @IBOutlet weak var awayTeamOddAddedValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with odds: [DatumUnion]?) {
        self.dateLabel.text = oddToDouble(odds?[0])?.toDateString()
        
        self.homeTeamOddsLabel.text = oddToDouble(odds?[2])?.description.formatToTwoDecimal()
        self.awayTeamOddLabel.text = oddToDouble(odds?[4])?.description.formatToTwoDecimal()
        
        guard let addedValue = oddToDouble(odds?[3]) else { return }

        setupPostiveValue(isNegative: addedValue.isNegative, addedValue: addedValue)
    }
    
    fileprivate func setupPostiveValue(isNegative: Bool, addedValue: Double) {
        if isNegative {
            homeTeamOddAddedValueLabel.text = addedValue.description.formatToTwoDecimal()
            homeTeamOddAddedValueLabel.textColor = .red
            
            awayTeamOddAddedValueLabel.text = (addedValue * -1).description.formatToTwoDecimal()
            awayTeamOddAddedValueLabel.textColor = .accent
        } else {
            awayTeamOddAddedValueLabel.text = addedValue.description.formatToTwoDecimal()
            awayTeamOddAddedValueLabel.textColor = .red
            
            homeTeamOddAddedValueLabel.text = (addedValue * -1).description.formatToTwoDecimal()
            homeTeamOddAddedValueLabel.textColor = .accent
        }
    }
    
    func oddToDouble(_ odd: DatumUnion?) -> Double? {
        switch odd {
        case .double(let intValue):
            return intValue
        case .string(_):
            return nil
        case .none:
            return nil
        }
    }
}
