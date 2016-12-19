//
//  TableFooterViewCell.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/19/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import UIKit

class TableFooterViewCell: UITableViewCell {
    @IBOutlet weak var weatherProperty: UILabel!

    @IBOutlet weak var weatherPropertyValue: UILabel!

    func configureTableFooterViewCell(tableFooterViewCellModel: TableFooterViewCellModel) {
        self.weatherProperty.text = tableFooterViewCellModel.weatherProperty
        self.weatherPropertyValue.text = tableFooterViewCellModel.weatherPropertyValue
    }
}
