//
//  CoinExchangeView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangeView: View {
    
    @StateObject private var viewModel = CoinExchangeViewViewModel()
    @State private var coinAmount : String = ""
    let exchangeType : ButtonsModel
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical,showsIndicators: false) {
                VStack {
                    CoinExchangeGreetingView(coin: coin)
                    CoinExchangePriceCalculatorView(coinAmount: $coinAmount, coin: coin)
                    CoinExchangeButtonView(viewModel: viewModel, buttonType: exchangeType, coin: coin, coinAmount: coinAmount)
                    
                }
            }.navigationTitle(exchangeType.buttonTitle + (" "+(coin.name ?? "")))

        }

    }
    
}
