//
//  PortfolioViewBuyOrSellButtons.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 6.03.2024.
//

import SwiftUI

struct PortfolioDetailBuyOrSellButtons: View {
    
    @Environment(\.presentationMode)  var presentationMode
    
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    @EnvironmentObject private var launchViewModel : LaunchViewViewModel
    
    @State var openSellScreen : Bool = false
    @State var openBuyScreen : Bool = false
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        HStack {
            
            BuyOrSellButtonItem(buttonType: .sell) {
                
                openSellScreen.toggle()
                
            }.sheet(isPresented: $openSellScreen, content: {
                CoinExchangeView(exchangeType: ButtonsModel.sell, coin: coin)
            })
            
            BuyOrSellButtonItem(buttonType: .buy) {
                
                openBuyScreen.toggle()
                
            }.sheet(isPresented: $openBuyScreen, content: {
                CoinExchangeView(exchangeType: ButtonsModel.buy, coin: coin)
            })
            
            
        }.padding()
            .padding(.vertical, 10)
            .onReceive(homeViewModel.$isCoinDeletedFromPortfolio, perform: { isDeleted in
                if isDeleted {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        presentationMode.wrappedValue.dismiss()
                        homeViewModel.isCoinDeletedFromPortfolio = false
                    }
                }
            })
    }
}
