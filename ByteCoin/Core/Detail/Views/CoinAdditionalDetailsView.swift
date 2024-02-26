//
//  CoinAdditionalDetailsView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import SwiftUI

struct CoinAdditionalDetailsView: View {
    
    let coinComesFromMarketView : AllCoinsDataResponseModel
    let coinComesFromViewModel : SingleCoinDataResponseModel
    
    private var columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private var spacing : CGFloat = 20
    
    init(coinComesFromMarketView: AllCoinsDataResponseModel, coinComesFromViewModel: SingleCoinDataResponseModel) {
        self.coinComesFromMarketView = coinComesFromMarketView
        self.coinComesFromViewModel = coinComesFromViewModel
    }
    
    var body: some View {
        VStack (alignment : .leading) {
            Text("Additional Details")
                .font(.title)
                .fontWeight(.bold)
            Divider()
            LazyVGrid(columns: columns,
                      alignment: .leading,
                      spacing: spacing,
                      content: {
                CoinDetailItem(
                    title: "24h High",
                    value: (coinComesFromMarketView.high24H?.convertCurrency()) ?? "n/a"
                )
                CoinDetailItem(
                    title: "24h Low",
                    value: (coinComesFromMarketView.low24H?.convertCurrency() ?? "n/a")
                )
                CoinDetailItem(
                    title: "24h Price Change",
                    value: coinComesFromMarketView.priceChange24H?.convertCurrency() ?? "n/a",
                    marketCapChange: coinComesFromMarketView.priceChangePercentage24H
                )
                CoinDetailItem(
                    title: "24h Market Cap Change",
                    value: "$" + (coinComesFromMarketView.marketCapChange24H?.convertWithAbbreviations() ?? "n/a"),
                    marketCapChange: coinComesFromMarketView.marketCapChangePercentage24H
                )
                CoinDetailItem(
                    title: "All Time High",
                    value: (coinComesFromMarketView.ath?.convertCurrency() ?? "n/a"),
                    marketCapChange: coinComesFromMarketView.athChangePercentage
                )
                CoinDetailItem(
                    title: "All Time Low",
                    value: (coinComesFromMarketView.atl?.convertCurrency() ?? "n/a"),
                    marketCapChange: coinComesFromMarketView.atlChangePercentage
                )
                
            })
            
        }.padding()
    }
}
