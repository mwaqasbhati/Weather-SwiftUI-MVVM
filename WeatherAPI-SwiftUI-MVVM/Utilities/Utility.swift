//
//  Utility.swift
//  WeatherAPI-SwiftUI-MVVM
//
//  Created by Muhammad Zohaib Ehsan on 3/26/20.
//  Copyright © 2020 Muhammad Zohaib Ehsan. All rights reserved.
//

import Foundation

struct Constant {
    static let YYYY_MM_dd_HH_mm_ss = "YYYY-MM-dd HH:mm:ss"
    static let HH_mm = "HH:mm"
}

extension Double {
    var celcius: Double {
        return (self - 273.15)
    }
    var formattedCelcius: String {
        return String(format: "%0.2f", celcius)
    }
}

extension Array where Element: Equatable {
    func removingDuplicates() -> Array {
        return reduce(into: []) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}
