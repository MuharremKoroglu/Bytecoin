//
//  BuyOrSellView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct BuyOrSellButtonsView: View {
    
    @StateObject var viewModel : CoinDetailViewViewModel
    
    @State var openSellScreen : Bool = false
    @State var openBuyScreen : Bool = false
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        HStack {
            
            BuyOrSellButtonItem(isButtonDisabled: viewModel.isCoinInPortfolio, buttonType: .sell) {
                openSellScreen.toggle()
            }.sheet(isPresented: $openSellScreen,onDismiss: {
                viewModel.getCoinPortfolioInfo(coin: coin)
            }) {
                CoinExchangeView(exchangeType: ButtonsModel.sell, coin: coin,isCoinInPortfolio: viewModel.isCoinInPortfolio)
            }
            BuyOrSellButtonItem(buttonType: .buy) {
                openBuyScreen.toggle()
            }.sheet(isPresented: $openBuyScreen,onDismiss: {
                viewModel.getCoinPortfolioInfo(coin: coin)
            }) {
                CoinExchangeView(exchangeType: ButtonsModel.buy, coin: coin)
            }
            
        }.padding()
            .onAppear{
                viewModel.getCoinPortfolioInfo(coin: coin)
            }
    }
    
}
