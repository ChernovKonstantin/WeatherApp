//
//  APIError.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import Foundation

enum APIError: Error {
//    case requestError
    case responseStatusError
    case imageDataError
    case dataTaskError
    case decoderError
}
