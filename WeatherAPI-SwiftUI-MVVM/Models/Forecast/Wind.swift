// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let wind = try? newJSONDecoder().decode(Wind.self, from: jsonData)

import Foundation

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}
