//
//  SendAgainView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct WatchListView: View {
    
    @EnvironmentObject private var launchViewModel : LaunchViewViewModel
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    
    var body: some View {
        VStack(alignment : .leading,spacing: 10) {
            Text("Watch List")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(homeViewModel.watchListCoins, id: \.id) { coin in
                        NavigationLink {
                            CoinDetailView(coin: coin)
                        } label: {
                            TopGainerAndLoserItem(coin: coin)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }.padding(.horizontal, 15)
            .onReceive(homeViewModel.$reloadWatchList) { isUpdated in
                if isUpdated {
                    Task {
                        await homeViewModel.getWatchListCoins(userId: launchViewModel.userId)
                    }
                }
            }
    }
}
