// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let coord = try? newJSONDecoder().decode(Coord.self, from: jsonData)

import Foundation

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double?
}
