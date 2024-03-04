//
//  CoinExchangeView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangeView: View {
    
    @State private var coinAmount : String = ""
    
    let exchangeType : ButtonsModel
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical,showsIndicators: false) {
                VStack {
                    CoinExchangeGreetingView(
                        coin: coin
                    )
                    CoinExchangePriceCalculatorView(
                        coinAmount: $coinAmount,
                        coin: coin,
                        exchangeType: exchangeType
                    )
                    CoinExchangeButtonView(
                        buttonType: exchangeType,
                        coin: coin,
                        coinAmount: coinAmount
                    )
                    
                }
            }.navigationTitle(exchangeType.buttonTitle)
            
        }

    }
    
}
