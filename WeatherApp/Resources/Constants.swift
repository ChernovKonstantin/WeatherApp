//
//  Constants.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import Foundation
import CoreLocation

func dateFrom(unixtimeInterval: Int, format: String = "E, d MMMM") -> String {
    let date = Date(timeIntervalSince1970: Double(unixtimeInterval))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+2")
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = format
    let strDate = dateFormatter.string(from: date)
    return strDate
}

