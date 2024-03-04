//
//  CoinExchangeButtonView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangeButtonView: View {
    
    @Environment(\.presentationMode)  var presentationMode
    
    @EnvironmentObject var homeViewModel : HomeViewViewModel
    
    let buttonType : ButtonsModel
    let coin : AllCoinsDataResponseModel
    let coinAmount : String
    
    var body: some View {
        BuyOrSellButtonItem(isCoinInPortfolio: homeViewModel.isCoinInPortfolio, buttonType: buttonType) {
            switch buttonType {
            case .buy:
                homeViewModel.buyCoin(coin: coin, newCoinAmount: coinAmount.convertToDouble())
            case .sell:
                homeViewModel.sellCoin(coin: coin, newCoinAmount: coinAmount.convertToDouble())
            }
        }.padding(.horizontal,25)
            .padding(.bottom, 15)
            .onReceive(homeViewModel.$isCompletedSuccessfully) { isSucceed in
                if isSucceed {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        presentationMode.wrappedValue.dismiss()
                        homeViewModel.isCompletedSuccessfully = false
                    }
                }
            }
    }
}
