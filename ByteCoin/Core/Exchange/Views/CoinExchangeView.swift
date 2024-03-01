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
    let isCoinInPortfolio : Bool
    
    init(exchangeType: ButtonsModel, coin: AllCoinsDataResponseModel,isCoinInPortfolio : Bool = true) {
        self.exchangeType = exchangeType
        self.coin = coin
        self.isCoinInPortfolio = isCoinInPortfolio
    }
    
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
                        viewModel: viewModel,
                        buttonType: exchangeType,
                        coin: coin,
                        coinAmount: coinAmount,
                        isCoinInPortfolio: isCoinInPortfolio
                    )
                    
                }
            }.navigationTitle(exchangeType.buttonTitle)
                .onAppear{
                    viewModel.getCoinHoldingInfo(coin: coin)
                }
            
        }

    }
    
}
