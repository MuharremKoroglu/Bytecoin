//
//  CoinOverViewView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import SwiftUI

struct CoinOverViewView: View {
    
   let coinComesFromMarketView : AllCoinsDataResponseModel
    
   private var spacing : CGFloat = 30
    
   private var columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    init(coinComesFromMarketView: AllCoinsDataResponseModel) {
        self.coinComesFromMarketView = coinComesFromMarketView
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
                    value: (coinComesFromMarketView.currentPrice?.convertCurrency()) ?? "n/a",
                    marketCapChange: coinComesFromMarketView.priceChangePercentage24H
                )
                CoinDetailItem(
                    title: "Market Capitalization",
                    value: "$" + (coinComesFromMarketView.marketCap?.convertWithAbbreviations() ?? "n/a") ,
                    marketCapChange: coinComesFromMarketView.marketCapChangePercentage24H
                )
                CoinDetailItem(
                    title: "Market Rank ",
                    value: coinComesFromMarketView.marketCapRank?.convertIntToString() ?? "n/a"
                )
                CoinDetailItem(
                    title: "Market Volume",
                    value: "$" + (coinComesFromMarketView.totalVolume?.convertWithAbbreviations() ?? "n/a")
                )
            })
            
        }.padding()
    }
}
