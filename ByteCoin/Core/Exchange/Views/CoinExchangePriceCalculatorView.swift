//
//  CoinExchangePriceView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangePriceCalculatorView: View {
    
    @Binding var coinAmount : String
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        VStack {
            
            CoinExchangePriceSection(
                sectionName: "Current Price",
                content: coin.currentPrice?.convertCurrency() ?? ""
            )
            
            CoinExchangeQuantitySection(
                sectionName: "What is the amount you want to buy?",
                coinAmount: $coinAmount
            )
            
            CoinExchangePriceSection(
                sectionName: "Total Amount",
                content: calculateTheTotalAmount().convertCurrency()
            )

        }.padding(.vertical, 20)
    }

}

extension CoinExchangePriceCalculatorView {
    
    private func calculateTheTotalAmount () -> Double {
        
        return coinAmount.convertToDouble() * (coin.currentPrice ?? 0)
    }
    
}
