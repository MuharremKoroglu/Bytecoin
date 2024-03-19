//
//  PortfolioDetails.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 6.03.2024.
//

import SwiftUI

struct PortfolioCoinDetails: View {
    
    let coin : AllCoinsDataResponseModel
     
     var body: some View {
         CoinDetailGridSharedView(title: "Portfolio Details") {
             Group {
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
             }
         }
     }
}
