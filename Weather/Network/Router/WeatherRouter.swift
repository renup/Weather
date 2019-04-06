//
//  WeatherRouter.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

typealias WeatherResponse = (_ weather: WeatherModel?, _ error: Error?) -> Void

final class WeatherRouter: APIRouter {
    
    @discardableResult
    static func getWeatherItems(completion: @escaping WeatherResponse) -> URLSessionTask? {
        return performRequest(route: WeatherEndpoint.weather(), completion: completion)
    }
    
}
