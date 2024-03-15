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
                    ForEach(viewModel.allCoins.indices, id: \.self) { index in
                        NavigationLink {
                            CoinDetailView(coin: viewModel.allCoins[index])
                        } label: {
                            CoinRow(coin: viewModel.allCoins[index])
                                .task {
                                    await viewModel.loadMoreCoinDataIfNeeded(currentIndex: index)
                                }
                        }.buttonStyle(PlainButtonStyle())
                            
                    }
                }
            }
            if viewModel.startProgressIndicator {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding(.bottom,10)
            }
        }
    }
}
