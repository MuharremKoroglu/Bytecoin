//
//  BuyOrSellView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct BuyOrSellButtonsView: View {
    
    let coin : AllCoinsDataResponseModel
    @State var openSellScreen : Bool = false
    @State var openBuyScreen : Bool = false
    
    var body: some View {
        HStack {
            
            BuyOrSellButtonItem(buttonType: .sell) {
                openSellScreen.toggle()
            }.sheet(isPresented: $openSellScreen) {
                CoinExchangeView(exchangeType: ButtonsModel.sell, coin: coin)
            }
            BuyOrSellButtonItem(buttonType: .buy) {
                openBuyScreen.toggle()
            }.sheet(isPresented: $openBuyScreen) {
                CoinExchangeView(exchangeType: ButtonsModel.buy, coin: coin)
            }
            
        }.padding()
    }
    
}
