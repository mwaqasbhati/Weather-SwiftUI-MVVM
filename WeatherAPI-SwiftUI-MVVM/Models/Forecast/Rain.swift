// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let rain = try? newJSONDecoder().decode(Rain.self, from: jsonData)

import Foundation

// MARK: - Rain
struct Rain: Codable, Equatable {
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}
