//
//  ContentView.swift
//  WeatherApp
//
//  Created by Kamil Klimacki on 15/06/2024.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                SearchView { text in
                    viewModel.cityName = text
                }
                Spacer()
                makeHeadInfo()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                makeMainInfo()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
        .task {
            await viewModel.fetchWeather()
        }
    }
    
    @ViewBuilder private func makeHeadInfo() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(viewModel.name)
                .bold()
                .font(.title)
            
            Text("Today: \(viewModel.dateFormatter)")
                .fontWeight(.light)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Spacer()
        
        VStack {
            HStack {
                VStack(spacing: 20) {
                    if let url = viewModel.image {
                        AsyncImage(url: url)
                    }
                    Text(viewModel.description)
                }
                .frame(width: 150, height: 250, alignment: .leading)
                
                Spacer()
                
                Text("\(viewModel.mainTemp)" + "°")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .padding(50)
            }
            
            Spacer()
                .frame(height: 80)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    @ViewBuilder private func makeMainInfo() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Weather Now")
                .bold()
                .padding(.bottom)
            
            HStack {
                WeatherRow(contition: .tempMin, value: (String(viewModel.minTemp) + "°"))
                Spacer()
                WeatherRow(contition: .tempMax, value: (String(viewModel.maxTemp) + "°"))
            }
            
            HStack {
//                WeatherRow(logo: "wind", name: "Wind speed", value: ("2" + " m/s"))
                Spacer()
                WeatherRow(contition: .humidity, value: String(viewModel.humidity))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .padding(.bottom, 20)
        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .background(.white)
        .cornerRadius(20)
    }
}

enum WeatherCondition {
    case tempMin
    case tempMax
    case humidity
    
    var logo: String {
        switch self {
        case .tempMin:
            return "thermometer"
        case .tempMax:
            return "thermometer"
        case .humidity:
            return "humidity"
        }
    }
    
    var name: String {
        switch self {
        case .tempMin:
            return "Min temp"
        case .tempMax:
            return "Max temp"
        case .humidity:
            return "humidity"
        }
    }
}



#Preview {
    WeatherView(viewModel: WeatherViewModel())
}


//rozszerzyć weather condition -> to enum powyżej
//dodać zakładkę ulubionych
//wysłać apkę na gita
