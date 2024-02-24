//
//  MarketView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import SwiftUI

struct MarketView: View {
    
    @StateObject private var viewModel = MarketViewViewModel()

    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarView(viewModel: viewModel)
                AllCoinView(viewModel: viewModel)
            }.navigationTitle("Coin Market")
                .onAppear{
                    viewModel.getAllCryptos()
                }
        }

    }
}

#Preview {
    MarketView()
}
