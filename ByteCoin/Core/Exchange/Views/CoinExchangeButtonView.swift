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
    
    var body: some View {
        BuyOrSellButtonItem(buttonType: buttonType) {
            viewModel.editPortfolio(coin: coin, coinAmount: coinAmount.convertToDouble(), buttonType: buttonType)
            if viewModel.saveSuccessfully {
                presentationMode.wrappedValue.dismiss()
            }
            
        }.padding(.horizontal,25)
            .padding(.bottom, 15)
    }
}
