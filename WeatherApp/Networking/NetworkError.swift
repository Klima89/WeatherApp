//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Kamil Klimacki on 15/06/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
