//
//  WeatherConditionsView.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import SwiftUI

struct WeatherConditionsView: View {
    var imageName: String
    var tempMin: Double
    var tempMax: Double
    var humidity: Int
    var wind: WindConditions
    
    var body: some View {
        HStack {
            Spacer()
            Image(imageName)
                .resizable()
                .frame(width: 120.0, height: 120.0)
                .padding(.trailing, 30)
            VStack(alignment: .leading) {
                conditionLine(image: "temp", condition: "\(Int(tempMin))°/\(Int(tempMax))°")
                conditionLine(image: "humidity", condition: "\(humidity)%")
                conditionLine(image: "wind", condition: "\(wind.speed)m/s", trailingImage: wind.direction)
                
            }
            Spacer()
        }
        .padding()
    }
    
    private func conditionLine(image: String, condition: String, trailingImage: String? = nil) -> some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 20.0, height: 20.0)
            Text(condition)
                .foregroundColor(.mainWhite)
                .font(.system(size: 20))
            if let trailingImage {
                Image(trailingImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30.0, height: 30.0)
            }
        }
    }
}

struct WeatherConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.mainDarkBlue.ignoresSafeArea()
            WeatherConditionsView(imageName: "day_thunder", tempMin: 2, tempMax: 1, humidity: 23, wind: WindConditions(speed: 11.5, deg: 111))
        }
    }
}
