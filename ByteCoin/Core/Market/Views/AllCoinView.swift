//
//  AllCoinView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import SwiftUI

struct AllCoinView: View {
    
    @StateObject var viewModel : MarketViewViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Coin")
                Spacer()
                Text("Price")
            }.font(.caption)
                .foregroundStyle(.gray)
                .padding(.horizontal,15)
            ScrollView(.vertical, showsIndicators : false) {
                VStack {
                    ForEach(viewModel.filteredCoins, id: \.id) { coin in
                        CoinRow(coin: coin)
                    }
                }
            }

        }
    }
}
