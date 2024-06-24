//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Kamil Klimacki on 15/06/2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: WeatherViewModel())
        }
    }
}
