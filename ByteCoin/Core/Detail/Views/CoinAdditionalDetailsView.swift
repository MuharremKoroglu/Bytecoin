//
//  CoinAdditionalDetailsView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import SwiftUI

struct CoinAdditionalDetailsView: View {
    
    let coin : AllCoinsDataResponseModel
    
    private var columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private var spacing : CGFloat = 30
    
    init(coin: AllCoinsDataResponseModel) {
        self.coin = coin
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
                    title: "24h Price Change",
                    value: coin.priceChange24H?.convertCurrency() ?? "n/a",
                    marketCapChange: coin.priceChangePercentage24H
                )
                CoinDetailItem(
                    title: "24h Market Cap Change",
                    value: "$" + (coin.marketCapChange24H?.convertWithAbbreviations() ?? "n/a"),
                    marketCapChange: coin.marketCapChangePercentage24H
                )
                CoinDetailItem(
                    title: "All Time High",
                    value: (coin.ath?.convertCurrency() ?? "n/a"),
                    marketCapChange: coin.athChangePercentage
                )
                CoinDetailItem(
                    title: "All Time Low",
                    value: (coin.atl?.convertCurrency() ?? "n/a"),
                    marketCapChange: coin.atlChangePercentage
                )
                
            })
            
        }.padding()
    }
}
