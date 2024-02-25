//
//  TopLoserView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 24.02.2024.
//

import SwiftUI

struct TopLoserView: View {
    @StateObject var viewModel : HomeViewViewModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            Text("Top Losers")
                .font(.headline)
                .fontWeight(.bold)
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(viewModel.topLoserCoins,id: \.id) { coin in
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
