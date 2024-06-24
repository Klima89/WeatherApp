
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Kamil Klimacki on 17/06/2024.


import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var forecast: Forecast? = nil
    @Published var weather: Forecast.WeatherInfo?
    
    @Published var cityName: String = "London" {
        didSet {
            Task{
                await fetchWeather()
            }
        }
    }
    
    init() {

    }
    
    var name: String {
        forecast?.name ?? ""
    }
    
    var image: URL? {
        weather?.iconURL ?? URL(string: "")
    }
    
    var description: String {
        weather?.description ?? ""
    }
    
    var mainTemp: Double {
        forecast?.main.temp ?? 0
    }
    
    var dateFormatter: String {
        Date().formatted(.dateTime.month().day())
    }
    
    var maxTemp: Double {
        forecast?.main.tempMax ?? 0
    }
    
    var minTemp: Double {
        forecast?.main.tempMin ?? 0
    }
    
    var humidity: Int {
        forecast?.main.humidity ?? 0
    }
    
    @MainActor
    func fetchWeather() async {
        let apiService = APIService()
        
        do {
            let weatherData = try await apiService.sendRequest(WeatherRequest(cityName: cityName))
            self.forecast = weatherData
            self.weather = weatherData.weather.first
        } catch {
            print("Error fetching weather data: \(error)")
        }
        
    }
}
