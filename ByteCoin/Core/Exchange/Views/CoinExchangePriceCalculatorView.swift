//
//  CoinExchangePriceView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangePriceCalculatorView: View {
    
    @EnvironmentObject var homeViewModel : HomeViewViewModel
    
    @Binding var coinAmount : String
    
    let coin : AllCoinsDataResponseModel
    let exchangeType : ButtonsModel
    
    var body: some View {
        VStack {
            
            CoinExchangePriceSection(
                sectionName: "Current Amount",
                content: homeViewModel.coinAmount.convertDoubleToStringFromInt()
            )
            
            CoinExchangeQuantitySection(
                sectionName: "What is the amount you want to \(exchangeType.rawValue)?",
                coinAmount: $coinAmount
            )
            
            CoinExchangePriceSection(
                sectionName: "Total Amount",
                content: calculateTheTotalAmount().convertCurrency()
            )
            
        }
    }

}

extension CoinExchangePriceCalculatorView {
    
    private func calculateTheTotalAmount () -> Double {
        
        return coinAmount.convertToDouble() * (coin.currentPrice ?? 0)
    }
    
}
