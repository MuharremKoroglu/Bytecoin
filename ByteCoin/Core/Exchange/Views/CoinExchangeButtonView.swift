//
//  CoinExchangeButtonView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangeButtonView: View {
    
    @Environment(\.presentationMode)  var presentationMode
    @StateObject var viewModel : CoinExchangeViewViewModel
    
    let buttonType : ButtonsModel
    let coin : AllCoinsDataResponseModel
    let coinAmount : String
    let isCoinInPortfolio : Bool
    
    var body: some View {
        BuyOrSellButtonItem(isButtonDisabled: isCoinInPortfolio, buttonType: buttonType) {
            switch buttonType {
            case .buy:
                viewModel.buyCoin(coin: coin, coinAmount: coinAmount.convertToDouble())
            case .sell:
                viewModel.sellCoin(coin: coin, coinAmount: coinAmount.convertToDouble())
            }
        }.padding(.horizontal,25)
            .padding(.bottom, 15)
            .onReceive(viewModel.$isCompletedSuccessfully) { isSucceed in
                if isSucceed {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
    }
}
