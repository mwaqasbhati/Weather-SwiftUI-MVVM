// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct CurrentWeatherResponse: Codable, Identifiable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
   // let cod: Int?
    
    var dataTime: String {
        let epochTime = dt
        let newTime = Date(timeIntervalSince1970: TimeInterval(epochTime ?? Int(Date().timeIntervalSince1970)))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.YYYY_MM_dd_HH_mm_ss
        return dateFormatter.string(from: newTime)
    }
}
