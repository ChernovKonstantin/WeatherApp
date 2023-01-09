//
//  APIService.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import Foundation

struct APIService {
    func makeRequest<T:Decodable>(request: APIRequest, lat: Double, lon: Double) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request.asURLRequest(lat: lat, lon: lon))
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw APIError.responseStatusError }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw APIError.decoderError
            }
        } catch {
            throw APIError.dataTaskError
        }
    }
}
