//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/19/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import UIKit
import AlamofireImage

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    func configureCell(weatherTableCellViewModel: WeatherTableViewCellModel) {
        self.dayLabel.text = weatherTableCellViewModel.dayLabel
        self.maxTempLabel.text = weatherTableCellViewModel.maxTempLabel
        self.minTempLabel.text = weatherTableCellViewModel.minTempLabel
        guard let iconImageURL = weatherTableCellViewModel.iconImageURL else { return }
        iconImageView.af_setImage(withURL: iconImageURL)
    }
}
