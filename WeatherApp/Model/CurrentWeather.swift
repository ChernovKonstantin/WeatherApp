//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import Foundation

struct CurrentWeather: Codable, Identifiable {
    let id = UUID()
    let main: WeatherConditions
    let weather: [ConditionsCode]
    let wind: WindConditions
    let date: Int
    let dateTxt: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case wind
        case date = "dt"
        case dateTxt = "dtTxt"
    }
}
