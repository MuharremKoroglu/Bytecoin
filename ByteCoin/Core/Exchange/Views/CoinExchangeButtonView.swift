//
//  CoinExchangeButtonView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangeButtonView: View {
    
    @Environment(\.presentationMode)  var presentationMode
    let buttonType : ButtonsModel
    
    var body: some View {
        BuyOrSellButtonItem(buttonType: buttonType) {
            presentationMode.wrappedValue.dismiss()
        }.padding(.horizontal,25)
            .padding(.bottom, 15)
    }
}

#Preview {
    CoinExchangeButtonView(buttonType: .buy)
}
