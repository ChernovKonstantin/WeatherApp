//
//  WindConditions.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import Foundation

struct WindConditions: Codable {
    let speed: Double
    let deg: Int
    
    var direction: String {
        switch deg {
        case 0...20, 261...380: return "wind_n"
        case 21...70: return "wind_ne"
        case 71...110: return "wind_e"
        case 111...160: return "wind_se"
        case 161...200: return "wind_s"
        case 201...260: return "wind_ws"
        case 261...300: return "wind_w"
        case 301...360: return "wind_wn"
        default: return ""
        }
    }
}




//"wind": {
//        "speed": 0.62,
//        "deg": 349,
//        "gust": 1.18
//      }


