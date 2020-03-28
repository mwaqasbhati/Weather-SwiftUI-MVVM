//
//  Utility.swift
//  WeatherAPI-SwiftUI-MVVM
//
//  Created by M.Waqas on 3/26/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    static let YYYY_MM_dd_HH_mm_ss = "YYYY-MM-dd HH:mm:ss"
    static let HH_mm = "HH:mm"
    static let MMM_d_YYYY = "MMM d"
    static let ALLOWED_CHAR = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ,"
    static let INPUT_TEXT_VALIDATION_ERROR = "you can search minimum 3 and maximum 7 cities and all should be comma separated."
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
