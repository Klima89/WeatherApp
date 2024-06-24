//
//  SearchView.swift
//  WeatherApp
//
//  Created by Kamil Klimacki on 17/06/2024.
//

import SwiftUI

struct SearchView: View {
    @State private var location: String = ""
    
    var onSearch: (String) -> Void
    
    var body: some View {

        HStack {
            TextField("Enter city name", text: $location)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .cornerRadius(3.0)
                .onSubmit {
                    onSearch(location)
                }
            Button(action: {
                onSearch(location)
            }) {
                Image(systemName: "magnifyingglass")
                    .padding()
            }
        }
    }
}


#Preview {
    SearchView(onSearch: { _ in })
    
}

