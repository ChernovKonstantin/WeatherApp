//
//  WeekForecastListView.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 05.01.2023.
//

import SwiftUI

private enum Constants {
    static let backgroundColor: Color = .mainWhite
}

struct WeekForecastListView: View {
    let weather: [[CurrentWeather]]
    @Binding var selectedRow: CurrentWeather?
    var body: some View {
        ZStack {
            backgroundView
            if !weather.isEmpty {
                listView
            }
        }
    }
    
    private var backgroundView: some View {
        Rectangle()
            .fill(Constants.backgroundColor)
            .edgesIgnoringSafeArea([.leading, .trailing])
    }
    
    private var listView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(weather, id: \.first!.id) { item in
                    if let weather = item.first {
                        HStack {
                            Text(dateFrom(unixtimeInterval: weather.date, format: "EE"))
                                .font(.system(size: 20))
                            Spacer()
                            Text("\(Int(weather.main.tempMin))°/\(Int(weather.main.tempMax))°")
                                .font(.system(size: 20))
                            Spacer()
                            if let image = weather.weather.first {
                                Image(image.weatherCode)
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding([.leading, .trailing], 10)
                        .foregroundColor(weather.id == selectedRow?.id ? Color.borderColor : Color.mainBlack)
                        .frame(height: 60)
                        .background(
                            Rectangle()
                                .fill(Color.mainWhite)
                                .shadow(color: weather.id == selectedRow?.id ? Color.borderColor : Color.mainWhite, radius: 5)
                        )
                        .onTapGesture {
                            selectedRow = weather
                        }
                    }
                }
            }.offset(y: 5)
        }
    }
}

struct WeekForecastListView_Previews: PreviewProvider {
    static var previews: some View {
        WeekForecastListView(weather: [[CurrentWeather(main: WeatherConditions(temp: 1, tempMin: 3, tempMax: 1, humidity: 1), weather: [ConditionsCode(id: 8)], wind: WindConditions(speed: 1, deg: 2), date: 1, dateTxt: "2")], [CurrentWeather(main: WeatherConditions(temp: 1, tempMin: 3, tempMax: 1, humidity: 1), weather: [ConditionsCode(id: 8)], wind: WindConditions(speed: 1, deg: 2), date: 1, dateTxt: "2")]], selectedRow: .constant(CurrentWeather(main: WeatherConditions(temp: 1, tempMin: 3, tempMax: 1, humidity: 1), weather: [ConditionsCode(id: 8)], wind: WindConditions(speed: 1, deg: 2), date: 1, dateTxt: "2")))
    }
}
