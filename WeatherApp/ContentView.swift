//
//  ContentView.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import SwiftUI
import CoreLocation
import MapKit

private enum Constants {
    static let backgroundColor: Color = .mainDarkBlue
}

struct ContentView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            contentView
        }
    }
    
    private var backgroundView: some View {
        Rectangle()
            .fill(Constants.backgroundColor)
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var contentView: some View {
        ZStack {
            backgroundView
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    topView
                    if let selectedWeather = viewModel.selectedWeather {
                        DayForecastScrollView(weather: selectedWeather)
                    }
                    WeekForecastListView(weather: viewModel.dailyForecast, selectedRow: $viewModel.weatherCurrent)
                }
            }
        }
    }
    
    @ViewBuilder
    private var topView: some View {
        if let weather = viewModel.weatherCurrent, let image = weather.weather.first {
            VStack(spacing: 0) {
                HStack {
                    LocationNameView(location: viewModel.locationName,
                                     date: dateFrom(unixtimeInterval: weather.date),
                                     action: AnyView(AddressSearchView(viewModel: viewModel.searchManager)))
                    Spacer()
                    VStack {
                        NavigationLink(destination: {
                            WeatherMapView(location: $viewModel.locationManager.lastLocation)
                                .ignoresSafeArea()
                        }, label: {
                            Image("location")
                        })
                        .padding()
                        Spacer()
                    }
                    
                }
                WeatherConditionsView(imageName: image.weatherCode,
                                      tempMin: weather.main.tempMin,
                                      tempMax: weather.main.tempMax,
                                      humidity: weather.main.humidity,
                                      wind: weather.wind)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
