//
//  CoinOverViewView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import SwiftUI

struct CoinOverViewView: View {
    
   let coin : AllCoinsDataResponseModel
    
    var body: some View {
        CoinDetailGridSharedView(title: "Overview") {
            Group {
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
            }
        }
    }
}


 

 
