//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import Combine
import CoreLocation
import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    @ObservedObject var locationManager = LocationService()
    @ObservedObject var searchManager = SearchManager()
    @Published var weatherCurrent: CurrentWeather?
    @Published var dailyForecast: [[CurrentWeather]] = []
    @Published var weatherForecast: [CurrentWeather] = []
    @Published var locationName: String = ""
    @Published var lastLocation: CLLocation?
    
    private var bag = Set<AnyCancellable>()
    private var isLoading = false
    
    var selectedWeather: [CurrentWeather]? {
        dailyForecast.first(where: { $0.first?.id == weatherCurrent?.id })
    }
    
    init() {
        subscribeToLocation()
    }
    
    @MainActor
    func fetchWeather(for location: CLLocation) async {
        guard !isLoading else { return }
        isLoading = true
        let apiService = APIService()
        do {
            let weatherForecastResponse: ForecastWeather = try await apiService.makeRequest(request: .forecast,
                                                                                            lat: location.coordinate.latitude,
                                                                                            lon: location.coordinate.longitude)
            weatherCurrent = weatherForecastResponse.list.first
            weatherForecast = weatherForecastResponse.list
            locationName = weatherForecastResponse.city.name
            createDailyForecast()
            isLoading = false
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    private func createDailyForecast() {
        dailyForecast.removeAll()
        var tempArray: [CurrentWeather] = []
        for item in weatherForecast {
            if tempArray.isEmpty {
                tempArray.append(item)
            } else if item.dateTxt.prefix(10) == tempArray.first?.dateTxt.prefix(10) {
                tempArray.append(item)
            } else {
                dailyForecast.append(tempArray)
                tempArray = [item]
            }
        }
    }
    
    private func subscribeToLocation() {
        locationManager.$lastLocation
            .compactMap({ $0 })
            .sink(receiveValue: { [weak self] location in
                self?.lastLocation = location
                Task {
                    await self?.fetchWeather(for: location)
                }
            }).store(in: &bag)
        
        searchManager.$lastLocation
            .compactMap({ $0 })
            .sink(receiveValue: { [weak self] location in
                self?.locationManager.lastLocation = location
            }).store(in: &bag)
    }
}
