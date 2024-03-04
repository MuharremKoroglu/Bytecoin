//
//  BuyOrSellButtonItem.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct BuyOrSellButtonItem: View {
    
    let isCoinInPortfolio : Bool
    let buttonType : ButtonsModel
    var buttonAction : (()->Void)?
    
    init(isCoinInPortfolio: Bool = false, buttonType: ButtonsModel, buttonAction: (() -> Void)? = nil) {
        self.isCoinInPortfolio = isCoinInPortfolio
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
            .disabled(buttonType == .sell && !isCoinInPortfolio)
            .opacity(buttonType == .sell && !isCoinInPortfolio ? 0.5 : 1)
            
        }
    }
}

