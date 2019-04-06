//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class WeatherDetailsViewController: UIViewController {
    
    struct Constants {
        static let cellIdentifier = "weekdayCell"
    }
    
    var cityName: String = ""
    var weekdayDataSource: [WeekDay] = [] {
        didSet {
            forecastTableView.reloadData()
        }
    }
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var weatherFeelsLikeDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var rainChanceLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherDetails()
    }
    
    private func getWeatherDetails() {
        WeatherViewModel.fetchWeatherDetail(city: cityName) { [weak self] (weatherDetail, error) in
            if error != nil {
                //show alert
            } else {
                guard let `self` = self, let weatherDetails = weatherDetail else { return }
                self.cityNameLabel.text = self.cityName
                self.weatherDescriptionLabel.text = weatherDetails.longDescription
                self.temperatureLabel.text = weatherDetails.feelsLike?.description
                self.weatherFeelsLikeDescriptionLabel.text = weatherDetails.feelsLike?.description
                self.humidityLabel.text = weatherDetails.humidity?.description
                self.rainChanceLabel.text = weatherDetails.rainChance?.description
                print("seven day = \(weatherDetails.sevenDay)")
            }
        }
    }
    
}

extension WeatherDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekdayDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! WeekdayCell
        cell.configureCell(for: weekdayDataSource[indexPath.row])
        return cell
    }
}
