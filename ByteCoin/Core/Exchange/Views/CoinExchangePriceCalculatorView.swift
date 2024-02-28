//
//  CoinExchangePriceView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangePriceCalculatorView: View {
    
    @State var coinAmount : String = ""
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        VStack {
            
            CoinExchangePriceSection(
                sectionName: "Current Price",
                content: coin.currentPrice?.convertCurrency() ?? ""
            )
            
            CoinExchangeQuantitySection(
                sectionName: "What is the amount you want to buy?",
                coinAmount: $coinAmount
            )
            
            CoinExchangePriceSection(
                sectionName: "Total Amount",
                content: calculateTheTotalAmount().convertCurrency()
            )

        }.padding(.vertical, 20)
    }

}

extension CoinExchangePriceCalculatorView {
    
    private func calculateTheTotalAmount () -> Double {
        
        let cleanedInput = coinAmount.replacingOccurrences(of: ",", with: ".")
        
        if let numberOfCoins = Double(cleanedInput) {
            return numberOfCoins * (coin.currentPrice ?? 0)
        }
        return 0
    }
    
}

#Preview {
    CoinExchangePriceCalculatorView(coin: AllCoinsDataResponseModel(id: "1", symbol: "BTC", name: "Bitcoin", image: "btc", currentPrice: 51102, marketCap: 1, marketCapRank: 1, fullyDilutedValuation: 1, totalVolume: 1, high24H: 1, low24H: 1, priceChange24H: 1, priceChangePercentage24H: 1, marketCapChange24H: 1, marketCapChangePercentage24H: 1, circulatingSupply: 1, totalSupply: 1, maxSupply: 1, ath: 1, athChangePercentage: 1, athDate: "", atl: 1, atlChangePercentage: 1, atlDate: "", roi: Roi(times: 1, currency: "", percentage: 1), lastUpdated: "", sparklineIn7D: SparklineIn7D(price: [1]), priceChangePercentage24HInCurrency: 1))
}
