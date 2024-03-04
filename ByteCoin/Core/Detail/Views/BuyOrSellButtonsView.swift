//
//  BuyOrSellView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct BuyOrSellButtonsView: View {
    
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    
    @State var openSellScreen : Bool = false
    @State var openBuyScreen : Bool = false
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        HStack {
            
            BuyOrSellButtonItem(isCoinInPortfolio : homeViewModel.isCoinInPortfolio, buttonType: .sell) {
                openSellScreen.toggle()
            }.sheet(isPresented: $openSellScreen,onDismiss: {
                homeViewModel.getSingleCoinFromFirebase(coin: coin)
                
            }) {
                CoinExchangeView(exchangeType: ButtonsModel.sell, coin: coin)
            }
            BuyOrSellButtonItem(buttonType: .buy) {
                openBuyScreen.toggle()
            }.sheet(isPresented: $openBuyScreen,onDismiss: {
                homeViewModel.getSingleCoinFromFirebase(coin: coin)
            }) {
                CoinExchangeView(exchangeType: ButtonsModel.buy, coin: coin)
            }
            
            
        }.padding()
            .onAppear{
                homeViewModel.getSingleCoinFromFirebase(coin: coin)
            }
    }
    
}
