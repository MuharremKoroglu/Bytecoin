//
//  CoinOverViewView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import SwiftUI

struct CoinOverViewView: View {
    
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
            Text("Overview")
                .font(.title)
                .fontWeight(.bold)
            Divider()
            LazyVGrid(columns: columns,
                      alignment: .leading,
                      spacing: spacing,
                      content: {
                CoinDetailItem(
                    title: "Current Price",
                    value: (coin.currentPrice?.convertCurrency()) ?? "n/a",
                    marketCapChange: coin.priceChangePercentage24H
                )
                CoinDetailItem(
                    title: "Market Capitalization",
                    value: "$" + (coin.marketCap?.convertWithAbbreviations() ?? "n/a") ,
                    marketCapChange: coin.marketCapChangePercentage24H
                )
                CoinDetailItem(
                    title: "Market Rank ",
                    value: coin.marketCapRank?.convertIntToString() ?? "n/a"
                )
                CoinDetailItem(
                    title: "Market Volume",
                    value: "$" + (coin.totalVolume?.convertWithAbbreviations() ?? "n/a")
                )
            })
            
        }.padding()
    }
}
