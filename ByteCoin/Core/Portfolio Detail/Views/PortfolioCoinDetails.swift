//
//  PortfolioDetails.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 6.03.2024.
//

import SwiftUI

struct PortfolioCoinDetails: View {
    
    let coin : AllCoinsDataResponseModel
     
    private var spacing : CGFloat = 30
     
    private var columns : [GridItem] = [
         GridItem(.flexible()),
         GridItem(.flexible()),
     ]
     
     init(coin: AllCoinsDataResponseModel) {
         self.coin = coin
     }
    
    var body: some View {
        VStack (alignment : .leading) {
            Text("Portfolio Details")
                .font(.title)
                .fontWeight(.bold)
            Divider()
            LazyVGrid(columns: columns,
                      alignment: .leading,
                      spacing: spacing,
                      content: {
                CoinDetailItem(
                    title: "Current Amount",
                    value: (coin.currentCoinAmount?.convertDoubleToStringFromInt()) ?? "n/a"
                )
                CoinDetailItem(
                    title: "Current Price",
                    value: (coin.currentPrice?.convertCurrency()) ?? "n/a"
                )
                CoinDetailItem(
                    title: "24h High",
                    value: (coin.high24H?.convertCurrency()) ?? "n/a"
                )
                CoinDetailItem(
                    title: "24h Low",
                    value: (coin.low24H?.convertCurrency() ?? "n/a")
                )
            })
            
        }.padding()
    }
}
