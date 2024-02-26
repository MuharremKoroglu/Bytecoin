//
//  CoinOverViewView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import SwiftUI

struct CoinOverViewView: View {
    
   let coinComesFromMarketView : AllCoinsDataResponseModel
   let coinComesFromViewModel : SingleCoinDataResponseModel
    
   private var spacing : CGFloat = 20
    
   private var columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    init(coinComesFromMarketView: AllCoinsDataResponseModel, coinComesFromViewModel: SingleCoinDataResponseModel) {
        self.coinComesFromMarketView = coinComesFromMarketView
        self.coinComesFromViewModel = coinComesFromViewModel
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
                    value: coinComesFromMarketView.marketCapRank?.convertNumberToString() ?? "n/a"
                )
                CoinDetailItem(
                    title: "Market Volume",
                    value: "$" + (coinComesFromMarketView.totalVolume?.convertWithAbbreviations() ?? "n/a")
                )
            })
            
        }.padding()
    }
}

#Preview {
    CoinOverViewView(coinComesFromMarketView: AllCoinsDataResponseModel(id: "", symbol: "BTC", name: "Bitcoin", image: "btc", currentPrice: 51102, marketCap: 1, marketCapRank: 1, fullyDilutedValuation: 1, totalVolume: 1, high24H: 1, low24H: 1, priceChange24H: 1, priceChangePercentage24H: 1, marketCapChange24H: 1, marketCapChangePercentage24H: 1, circulatingSupply: 1, totalSupply: 1, maxSupply: 1, ath: 1, athChangePercentage: 1, athDate: "", atl: 1, atlChangePercentage: 1, atlDate: "", roi: Roi(times: 1, currency: "", percentage: 1), lastUpdated: "", sparklineIn7D: SparklineIn7D(price: [1]), priceChangePercentage24HInCurrency: 1), coinComesFromViewModel: SingleCoinDataResponseModel(id: "", symbol: "BTC", name: "Bitcoin", hashingAlgorithm: "SHA-256", description: Description(en: ""), links: ImportantLinks(homepage: [""], whitepaper: "")))
}
