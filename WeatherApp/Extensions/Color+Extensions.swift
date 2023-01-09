//
//  Color+Extensions.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

extension Color {
    static let mainWhite = Color(hex: 0xFFFFFF)
    static let mainBlack = Color(hex: 0x000000)
    static let mainDarkBlue = Color(hex: 0x4A90E2)
    static let mainBlue = Color(hex: 0x5A9FF0)
    static let borderColor = Color(hex: 0x5A9FF0)
}
