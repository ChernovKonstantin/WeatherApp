//
//  Conditions.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import Foundation

struct ConditionsCode: Codable {
    let id: Int
    
    var weatherCode: String {
        switch id/100 {
        case 2: return "day_thunder"
        case 3: return "day_rain"
        case 5: return "day_shower"
        case 6: return "day_shower"
        case 7: return "day_cloudy"
        case 8: if id%8 == 0{
            return "day_bright"
        } else  {
            return "day_cloudy"
        }
        default: return "day_bright"
        }
    }
}
