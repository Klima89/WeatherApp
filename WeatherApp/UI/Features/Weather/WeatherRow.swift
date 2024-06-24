//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Stephanie Diep on 2021-11-30.
//

import SwiftUI

struct WeatherRow: View {
    var contition: WeatherCondition
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: contition.logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                .cornerRadius(50)

            VStack(alignment: .leading, spacing: 8) {
                Text(contition.name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title)
            }
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(contition: .tempMax, value: "20")
    }
}
