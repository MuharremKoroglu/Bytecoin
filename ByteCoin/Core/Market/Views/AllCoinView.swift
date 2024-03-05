//
//  AllCoinView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import SwiftUI

struct AllCoinView: View {
    
    @EnvironmentObject private var viewModel : HomeViewViewModel
    
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
                LazyVStack {
                    ForEach(viewModel.filteredMarketCoins, id: \.id) { coin in
                        NavigationLink {
                            CoinDetailView(coin: coin)
                        } label: {
                            CoinRow(coin: coin)
                        }.buttonStyle(PlainButtonStyle()) 
                        
                    }
                }
            }
        }
    }
}
