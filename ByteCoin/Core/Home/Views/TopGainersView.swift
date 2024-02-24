//
//  RecommendedToBuyView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct TopGainersView: View {
    @StateObject var viewModel : HomeViewViewModel
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            Text("Top Gainers")
                .font(.headline)
                .fontWeight(.bold)
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(viewModel.topGainerCoins,id: \.id) { coin in
                        TopGainerAndLoserItem(coin: coin)
                    }
                }
            }
            
            
        }.padding(.horizontal, 15)
    }
}
