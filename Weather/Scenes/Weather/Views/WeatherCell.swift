//
//  WeatherCell.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    func configureCell(_ city: City) {
        self.cityName.text = city.name
        self.temperatureLabel.text = city.temp?.description
    }
}
