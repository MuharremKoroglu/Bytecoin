//
//  BuyOrSellView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct BuyOrSellButtonsView: View {
    
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    @EnvironmentObject private var launchViewModel : LaunchViewViewModel
    
    @State var openSellScreen : Bool = false
    @State var openBuyScreen : Bool = false
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        HStack {
            
            BuyOrSellButtonItem(coin: homeViewModel.updatedCoin ?? coin, buttonType: .sell) {
                
                openSellScreen.toggle()
                
            }.sheet(isPresented: $openSellScreen,onDismiss: {
                
                homeViewModel.getSingleCoinFromFirebase(userId : launchViewModel.userId, coin: coin)
                
            }) {
                CoinExchangeView(exchangeType: ButtonsModel.sell, coin: homeViewModel.updatedCoin ?? coin)
            }
            
            BuyOrSellButtonItem(coin: homeViewModel.updatedCoin ?? coin, buttonType: .buy) {
                
                openBuyScreen.toggle()
                
            }.sheet(isPresented: $openBuyScreen,onDismiss: {
                
                homeViewModel.getSingleCoinFromFirebase(userId : launchViewModel.userId, coin: coin)
                
            }) {
                CoinExchangeView(exchangeType: ButtonsModel.buy, coin: homeViewModel.updatedCoin ?? coin)
            }
            
            
        }.padding()
            .onAppear{
                homeViewModel.getSingleCoinFromFirebase(userId : launchViewModel.userId, coin: coin)
            }
    }
    
}
