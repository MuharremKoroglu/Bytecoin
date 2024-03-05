//
//  RecommendedToBuyView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct TopGainersView: View {
    
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            Text("Top Gainers")
                .font(.headline)
                .fontWeight(.bold)
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(homeViewModel.topGainerCoins,id: \.id) { coin in
                        NavigationLink {
                            CoinDetailView(coin: coin)
                        } label: {
                            TopGainerAndLoserItem(coin: coin)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }.padding(.horizontal, 15)
    }
}
