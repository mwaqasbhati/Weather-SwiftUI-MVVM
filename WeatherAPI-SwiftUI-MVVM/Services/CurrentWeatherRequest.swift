//
//  CurrentWeatherService.swift
//  WeatherAPI-SwiftUI-MVVM
//
//  Created by M.Waqas on 3/25/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import Foundation

struct CurrentWeatherRequest: APIRequestType {
    
    typealias Response = CurrentWeatherResponse
    
    init(_ params: [String: String]) {
        queryParams = params
    }
    
    var queryParams: [String : String]
    var path: String { return "/data/2.5/weather" }
    var queryItems: [URLQueryItem]? {
        return queryParams.map {
            // Swift 4
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
}
