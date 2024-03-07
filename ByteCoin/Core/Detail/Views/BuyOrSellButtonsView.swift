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
            
            BuyOrSellButtonItem(isButtonDisabled : buyOrSellButtonDisabled(), buttonType: .sell) {
                
                openSellScreen.toggle()
                
            }.sheet(isPresented: $openSellScreen,onDismiss: {
                
                homeViewModel.getSinglePortfolioCoin(userId : launchViewModel.userId, coin: coin)
                
            }) {
                CoinExchangeView(exchangeType: ButtonsModel.sell, coin: homeViewModel.updatedCoin ?? coin)
            }
            
            BuyOrSellButtonItem(buttonType: .buy) {
                
                openBuyScreen.toggle()
                
            }.sheet(isPresented: $openBuyScreen,onDismiss: {
                
                homeViewModel.getSinglePortfolioCoin(userId : launchViewModel.userId, coin: coin)
                
            }) {
                CoinExchangeView(exchangeType: ButtonsModel.buy, coin: homeViewModel.updatedCoin ?? coin)
            }
            
            
        }.padding()
            .onAppear{
                homeViewModel.getSinglePortfolioCoin(userId : launchViewModel.userId, coin: coin)
            }
    }
    
}

extension BuyOrSellButtonsView {
    
    func buyOrSellButtonDisabled () -> Bool {
        return homeViewModel.updatedCoin?.currentCoinAmount == 0
    }
    
}
