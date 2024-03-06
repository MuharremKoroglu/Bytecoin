//
//  BuyOrSellButtonItem.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct BuyOrSellButtonItem: View {
    
    let coin : AllCoinsDataResponseModel
    let buttonType : ButtonsModel
    var buttonAction : (()->Void)?
    
    init(coin : AllCoinsDataResponseModel,buttonType: ButtonsModel, buttonAction: (() -> Void)? = nil) {
        self.coin = coin
        self.buttonType = buttonType
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        VStack {
            Button(action: {
                buttonAction?()
            }, label: {
                HStack {
                    Text(buttonType.buttonTitle)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Image(systemName: buttonType.buttonIcon)
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }).background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(buttonType.buttonColor)
            )
            .disabled(buttonType == .sell && coin.currentCoinAmount == 0)
            .opacity(buttonType == .sell && coin.currentCoinAmount == 0 ? 0.5 : 1)
            
        }
    }
}

