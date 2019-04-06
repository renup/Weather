//
//  WeatherEndpoint.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

enum WeatherEndpoint: APIConfiguration {
    
    case weather()
    case weatherDetails(cityName: String)
    
    struct Constants {
        static let baseURLString = "http://localhost:8080"
        static let weather = "/weather"
        static let detailedForecast = "/detailed-forecast"
    }
    
    var path: String {
        switch self {
        case .weather():
            return Constants.baseURLString + Constants.weather
        case .weatherDetails(_):
            return Constants.baseURLString + Constants.detailedForecast
        }
    }
    
    var parameters: [URLQueryItem] {
        switch  self {
        case .weather():
           return []
        case .weatherDetails(let cityName):
            let cityNameQuery = URLQueryItem(name: "city", value: cityName)
            return [cityNameQuery]
        }
    }    
    
}
