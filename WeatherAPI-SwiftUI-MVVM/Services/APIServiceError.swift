//
//  APIServiceError.swift
//  SwiftUI-MVVM
//
//  Created by M.Waqas on 3/25/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    case responseError
    case networkError
    case parseError(Error)
    case locationNotFound
    
    var localizedDescription: String {
        switch self {
        case .responseError: return "network error"
        case .parseError: return "Invalid response from server, please check city name spellings."
        case .networkError: return "Network is not available, please try again later."
        case .locationNotFound: return "Your current location not found."
        }
    }
}

