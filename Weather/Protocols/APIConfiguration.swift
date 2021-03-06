//
//  APIConfiguration.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

protocol APIConfiguration {
    var path: String { get }
    var parameters: [URLQueryItem] { get }
}
