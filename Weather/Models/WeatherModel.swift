//
//  WeatherModel.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    var cities: [City]?
}

struct City: Decodable {
    var country: String?
    var name: String?
    var temp: Double?
}
