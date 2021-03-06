//
//  APIRouter.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

///Protocol that declares the methods for performing actual requests
protocol APIRouter {
    static func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping ((T?, Error?) -> Void)) -> URLSessionTask?
}

extension APIRouter {
    
    /// Builds the http url using parameters
    ///
    /// - Parameter route: request path for the url
    /// - Returns: returns the URL for request
    private static func  getURL(route: APIConfiguration) -> URL? {
        let path = route.path
        
        guard var urlComponents = URLComponents(string: path) else { return nil }
        if route.parameters.count >= 1 {
            urlComponents.queryItems = route.parameters
        }
        
        guard let url = urlComponents.url else { return nil }
        return url
    }
    
    /// Performs actual request and creates model objects from resulting data
    ///
    /// - Parameters:
    ///   - route: path for api request
    ///   - completion: completion handler for the result received
    /// - Returns: session task back to calling method
    static func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping ((T?, Error?) -> Void)) -> URLSessionTask? {
        
        guard let url = getURL(route: route) else { return nil }
        
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let dt = data {
                #if DEBUG
                print( String(describing: dt))
                #endif
                do{
                    let result = try JSONDecoder().decode(T.self, from: dt)
                    completion(result, nil)
                } catch(let error) {
                    print("error = \(error)")
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        })
        dataTask.resume()
        return dataTask
    }
    
}
