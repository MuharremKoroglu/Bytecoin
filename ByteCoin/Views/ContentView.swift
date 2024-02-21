//
//  ContentView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HomeScreenViewModel()
    var body: some View {
        VStack {
            List(viewModel.allCurrencies, id: \.id) { crypto in
                Text(crypto.name?.uppercased() ?? "Veri Getirilemedi")
            }
        }.padding()
            .onAppear {
                viewModel.getAllCryptoCurrencies()
            }
        
    }
}

#Preview {
    ContentView()
}
