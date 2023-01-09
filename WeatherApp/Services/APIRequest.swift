//
//  APIRequest.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import Foundation

enum APIRequest {
    
    case current
    case forecast
    
    func asURLRequest(url: String = "", lat: Double, lon: Double) -> URLRequest {
        let params = ["lat": "\(lat)", "lon": "\(lon)", "appid": APICreds.authToken, "units": "metric"]
        switch self {
        case .current:
            return buildRequest(urlString: "\(APICreds.baseURl)/weather", parameters: params)
        case .forecast:
            return buildRequest(urlString: "\(APICreds.baseURl)/forecast", parameters: params)
        }
    }
    
    private func buildRequest(urlString: String, parameters: [String:String]? = nil) -> URLRequest {
        
        let headers = [
            "Accept": "application/json",
        ]
        
        var urlWithParameters = urlString
        if parameters?.isEmpty == false {
            urlWithParameters += "?"
            parameters?.forEach { name, value in
                urlWithParameters += "\(name)=\(value)&"
            }
        }
        var request = URLRequest(url: URL(string: urlWithParameters)!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
        
    }
}
