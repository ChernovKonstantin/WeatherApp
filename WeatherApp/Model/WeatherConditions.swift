//
//  WeatherConditions.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import Foundation

struct WeatherConditions: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    enum CodingKeys: String, CodingKey {
        case temp
        case humidity
        case tempMin = "tempMin"
        case tempMax = "tempMax"
    }
}
