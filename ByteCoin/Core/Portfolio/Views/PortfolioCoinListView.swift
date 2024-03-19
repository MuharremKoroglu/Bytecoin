//
//  PortfolioCoinListView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import SwiftUI

struct PortfolioCoinListView: View {
    
    @EnvironmentObject var homeViewModel : HomeViewViewModel
    @EnvironmentObject var launchViewModel : LaunchViewViewModel
        
    var body: some View {
        VStack {
            HStack {
                Text("Coin")
                Spacer()
                Text("Holdings")
                Text("Total")
                    .frame(width: 110,alignment: .trailing)
            }.font(.caption)
                .foregroundStyle(.gray)
                .padding(.horizontal,15)
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(homeViewModel.filteredPortfolioCoins, id: \.id) { coin in
                        NavigationLink {
                            PortfolioDetailView(coin: coin)
                        } label: {
                            PortfolioCoinRow(coin: coin)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }.onReceive(homeViewModel.$reloadPortfolio) { isUpdated in
            if isUpdated {
                Task {
                   await homeViewModel.getPortfolioCoins(userId: launchViewModel.userId)
                }
            }
        }
        
    }
}
