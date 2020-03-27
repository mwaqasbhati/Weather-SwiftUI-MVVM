//
//  SearchRepositoryRequest.swift
//  SwiftUI-MVVM
//
//  Created by M.Waqas on 3/25/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import Foundation

struct ForecastRequest: APIRequestType {
    
    typealias Response = ForecastResponse
    
    var queryParams: [String : String]
    
    init(_ params: [String: String]) {
        queryParams = params
    }
    
    var path: String { return "/data/2.5/forecast" }
    var queryItems: [URLQueryItem]? {
        return queryParams.map {
            // Swift 4
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
}
