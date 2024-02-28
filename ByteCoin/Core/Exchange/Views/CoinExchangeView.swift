//
//  CoinExchangeView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangeView: View {
    
    let exchangeType : ButtonsModel
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical,showsIndicators: false) {
                VStack {
                    CoinExchangeGreetingView(coin: coin)
                    CoinExchangePriceCalculatorView(coin: coin)
                    CoinExchangeButtonView(buttonType: exchangeType)
                    
                }
            }.navigationTitle(exchangeType.buttonTitle + (" "+(coin.name ?? "")))

        }

    }
    
}

#Preview {
    CoinExchangeView(exchangeType: .buy, coin: AllCoinsDataResponseModel(id: "1", symbol: "BTC", name: "Bitcoin", image: "btc", currentPrice: 51102, marketCap: 1, marketCapRank: 1, fullyDilutedValuation: 1, totalVolume: 1, high24H: 1, low24H: 1, priceChange24H: 1, priceChangePercentage24H: 1, marketCapChange24H: 1, marketCapChangePercentage24H: 1, circulatingSupply: 1, totalSupply: 1, maxSupply: 1, ath: 1, athChangePercentage: 1, athDate: "", atl: 1, atlChangePercentage: 1, atlDate: "", roi: Roi(times: 1, currency: "", percentage: 1), lastUpdated: "", sparklineIn7D: SparklineIn7D(price: [1]), priceChangePercentage24HInCurrency: 1))
}
