//
//  DayForecastScrollView.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import SwiftUI

private enum Constants {
    static let backgroundColor: Color = .mainBlue
}

struct DayForecastScrollView: View {
    var weather: [CurrentWeather]
    var body: some View {
        ZStack {
            backgroundView
            listView
        }.frame(height: 140)
    }
    
    private var backgroundView: some View {
        Rectangle()
            .fill(Constants.backgroundColor)
    }
    
    private var listView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(weather, id: \.id) { weather in
                    VStack {
                        HStack(alignment: .top, spacing: 4) {
                            Text(dateFrom(unixtimeInterval: weather.date, format: "HH"))
                                .foregroundColor(.mainWhite)
                                .font(.system(size: 20))
                                .lineLimit(1)
                            Text("00")
                                .foregroundColor(.mainWhite)
                                .font(.system(size: 10))
                        }
                        if let image = weather.weather.first?.weatherCode {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30.0, height: 30.0)
                        }
                        Text("\(Int(weather.main.temp))°")
                            .foregroundColor(.mainWhite)
                            .font(.system(size: 20))
                    }
                    .padding(14)
                }
            }
        }
    }
}

struct WeatherForecastListView_Previews: PreviewProvider {
    static var previews: some View {
        DayForecastScrollView(weather: [])
    }
}
