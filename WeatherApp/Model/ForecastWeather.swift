//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import Foundation

struct ForecastWeather: Codable {
    let list: [CurrentWeather]
    let city: WeatherCity
}

