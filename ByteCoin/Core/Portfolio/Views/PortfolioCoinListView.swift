//
//  PortfolioCoinListView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import SwiftUI

struct PortfolioCoinListView: View {
    
    @StateObject var viewModel : PortfolioViewViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Coin")
                Spacer()
                Text("Amount")
                Spacer()
                Text("Total")
            }.font(.caption)
                .foregroundStyle(.gray)
                .padding(.horizontal,15)
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(viewModel.portfolioCoins, id: \.id) { coin in
                        PortfolioCoinRow(coin: coin)
                    }
                }
                
            }
            
        }
    }
}
