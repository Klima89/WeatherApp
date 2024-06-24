//
//  APIService.swift
//  WeatherApp
//
//  Created by Kamil Klimacki on 15/06/2024.
//

import Foundation
import CoreLocation


//
//class APIService {
//    func getCurrentWeather(name: String) async throws -> Forecast {
//        let endpoint = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=dd8038f5e50148160714cc71e9d2c6da&units=metric"
//        guard let url = URL(string: endpoint) else { throw NetworkError.invalidURL }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw NetworkError.invalidResponse
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .deferredToDate
//            return try decoder.decode(Forecast.self, from: data)
//        } catch {
//            throw NetworkError.invalidData
//        }
//        
//    }
//}

protocol APIServiceProtocol {
    func sendRequest<T: APIRequest>(_ request: T) async throws -> T.Response
}

protocol APIRequest {
    associatedtype Response: Codable
    var endpoint: String { get }
    var url: URL? { get }
}

struct WeatherRequest: APIRequest {
    typealias Response = Forecast
    
    let cityName: String
    let apiKey: String = "dd8038f5e50148160714cc71e9d2c6da"
    let units: String = "metric"

    var endpoint: String {
        "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=\(units)"
    }

    var url: URL? {
        URL(string: endpoint)
    }
}


class APIService: APIServiceProtocol {
    func sendRequest<T: APIRequest>(_ request: T) async throws -> T.Response {
        guard let url = request.url else { throw NetworkError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .deferredToDate
            return try decoder.decode(T.Response.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}

