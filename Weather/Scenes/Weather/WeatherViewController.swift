//
//  ViewController.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var cities: [City] = [] {
        didSet {
            weatherTableView.reloadData()
        }
    }
    
    struct Constants {
        static let cellIdentifier = "weatherCell"
    }
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWeatherScene()
        getWeather()
    }
    
    private func setUpWeatherScene() {
        weatherTableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "weatherCell")
    }
    
    private func getWeather() {
        
        WeatherViewModel.fetchWeather {[weak self] (weather, error) in
            if error != nil {
                //show alert
            } else {
                guard let weatherInfo = weather, let cities = weatherInfo.cities else { return }
                self?.cities = cities
            }
        }
    }


}

extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! WeatherCell
        cell.configureCell(cities[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        <#code#>
//    }
    
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

