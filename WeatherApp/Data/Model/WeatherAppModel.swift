//
//  WeatherAppModel.swift
//  WeatherApp
//
//  Created by Kamil Klimacki on 15/06/2024.
//

import Foundation
import CoreLocation


struct Forecast: Codable {
    let weather: [WeatherInfo]
    let main: WeatherMainInfo
    
    let dt: Date
    let name: String
    
    struct WeatherInfo: Codable {
        let description: String
        let icon: String
        
        var iconURL: URL {
            let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
            return URL(string: urlString)!
        }
    }
    
    struct WeatherMainInfo: Codable {
        let temp: Double
        let tempMin: Double
        let tempMax: Double
        let humidity: Int
        
        enum CodingKeys: String, CodingKey {
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case temp, humidity
        }
    }
}
