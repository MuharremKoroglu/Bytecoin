//
//  RecommendedToBuyView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct RecommendedToBuyView: View {
    @StateObject var viewModel : HomeViewViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended to Buy")
                .font(.headline)
                .fontWeight(.bold)
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(viewModel.recommendedCoins,id: \.id) { coin in
                        RecommendedToBuy(coin: coin)
                    }
                }
            }
            
            
        }.padding(.vertical, 15)
            .padding(.horizontal, 15)
    }
}
