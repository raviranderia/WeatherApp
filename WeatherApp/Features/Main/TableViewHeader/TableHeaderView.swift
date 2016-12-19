//
//  TableHeaderView.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/19/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import UIKit

final class TableHeaderView: UIView {

    @IBOutlet weak var mainWeatherImageView: UIImageView!
    
    @IBOutlet weak var mainTemperatureLabel: UILabel!

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    func configureTableViewHeader(tableHeaderViewModel: TableHeaderViewModel) {
        mainTemperatureLabel.text = tableHeaderViewModel.currentTemperatureLabel
        dayLabel.text = tableHeaderViewModel.dayLabel
        minLabel.text = tableHeaderViewModel.minLabel
        maxLabel.text = tableHeaderViewModel.maxLabel
        guard let imageURL = tableHeaderViewModel.currentWeatherImageURL else { return }
        self.mainWeatherImageView.af_setImage(withURL: imageURL)
    }
    
    class func instanceFromNib() -> TableHeaderView {
        return UINib(nibName: "TableHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TableHeaderView
    }
}
