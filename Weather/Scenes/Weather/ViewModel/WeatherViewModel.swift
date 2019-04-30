//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

typealias GroupedCities = (_ countryArray: [Country]?, _ error: Error?) -> Void

struct Country {
    var name: String
    var cities: [City]
}

final class WeatherViewModel {
    
    @discardableResult
    static func fetchWeather(completion: @escaping GroupedCities) -> URLSessionTask? {
        let task = WeatherRouter.getWeatherItems { (weatherModel, error) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(nil, error)
                } else {
                    if let cities = weatherModel?.cities {
                        let dictionary = Dictionary(grouping: cities, by: { $0.country })
                        
                        let countryKeys = dictionary.keys
                        var countryArray: [Country] = []
                        for country in countryKeys {
                            let cntry = Country(name: country!, cities: dictionary[country]!)
                            countryArray.append(cntry)
                        }
                        let sortedCountry = countryArray.sorted(by:  {$0.name < $1.name } )
                        var sortedCountryAndCity: [Country] = []
                        
                        for var ele in sortedCountry {
                            let cities = ele.cities
                            let sortedCities = cities.sorted(by: {$0.name! < $1.name!})
                            ele.cities = sortedCities
                            sortedCountryAndCity.append(ele)
                        }
                        
                        completion(sortedCountryAndCity, nil)
                        return
                    }
                    completion(nil, nil)
                }
            }
        }
        return task
    }
    
    @discardableResult
    static func fetchWeatherDetail(city: String, completion: @escaping WeatherDetailsResponse) -> URLSessionTask? {
        let task = WeatherRouter.getWeatherDetail(for: city, completion: { (weatherDetail, error) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(nil, error)
                } else {
                    completion(weatherDetail, nil)
                }
            }
        })
        return task
    }
    
    
}

