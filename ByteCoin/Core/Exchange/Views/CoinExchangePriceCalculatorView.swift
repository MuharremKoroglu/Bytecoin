//
//  CoinExchangePriceView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangePriceCalculatorView: View {
    
    @EnvironmentObject var homeViewModel : HomeViewViewModel
    
    @Binding var transactionCoinAmount : String
    
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
                coinAmount: $transactionCoinAmount
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
        
        return transactionCoinAmount.convertToDouble() * (coin.currentPrice ?? 0)
    }
    
}
