//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 06.01.2023.
//

import Foundation
import MapKit
import SwiftUI
import Combine

class SearchManager: NSObject, ObservableObject {
    @Published var searchResults: [MKLocalSearchCompletion] = []
    @Published var query: String = ""
    @Published var selection: MKLocalSearchCompletion?
    @Published var lastLocation: CLLocation?
    private var subjectListener: AnyCancellable?
    
    var searchCompleter = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
        subscribe()
    }
    
    func reset() {
        searchResults = []
    }
    
    func searchCoordinates(for result: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: result)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                return
            }
            self.lastLocation = CLLocation(latitude: coordinate.latitude,
                                           longitude: coordinate.longitude)
        }
    }
    
    func subscribe() {
        subjectListener = $selection
            .compactMap({ $0 })
            .sink(receiveValue: { [weak self] location in
                guard let self else { return }
                self.searchCoordinates(for: location)
            })
    }
    
}

extension SearchManager: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
}
