// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let list = try? newJSONDecoder().decode(List.self, from: jsonData)

import Foundation

enum WeekDay: Int, Comparable {
    
    static func < (lhs: WeekDay, rhs: WeekDay) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    case sun = 1, mon = 2,tue = 3,wed = 4,thu = 5,fri = 6,sat = 7, none = 8
    var dayValue: String {
        switch self {
        case .mon:
            return "Monday"
        case .tue:
            return "Tuesday"
        case .wed:
            return "Wednesday"
        case .thu:
            return "Thursday"
        case .fri:
            return "Friday"
        case .sat:
            return "Saturday"
        case .sun:
            return "Sunday"
        case .none:
            return ""
        }
    }
}
// MARK: - List
struct Forecast: Codable, Identifiable, Equatable {
    let dt: Int?
    let main: MainClass?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let sys: Sys?
    let dtTxt: String?
    let rain: Rain?

    var weekDayString: String? {
        //2020-03-25 18:00:00
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.YYYY_MM_dd_HH_mm_ss
        if let dtTxt = dtTxt, let date = dateFormatter.date(from: dtTxt) {
            let weekday = Calendar.current.component(.weekday, from: date)
            return WeekDay(rawValue: weekday)?.dayValue
        }
        return nil
    }
    var time: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.YYYY_MM_dd_HH_mm_ss
        if let dtTxt = dtTxt, let date = dateFormatter.date(from: dtTxt) {
            dateFormatter.dateFormat = Constant.HH_mm
            return dateFormatter.string(from: date)
        }
        return nil
    }
    var id: Int {
        return dt ?? 0
    }

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt = "dt_txt"
        case rain
    }
}
