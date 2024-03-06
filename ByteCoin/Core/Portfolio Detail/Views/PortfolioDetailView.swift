//
//  PortfolioDetailView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 6.03.2024.
//

import SwiftUI

struct PortfolioDetailView: View {
        
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(alignment: .leading) {
                PortfolioCoinGreeting(coin: coin)
                PortfolioViewBuyOrSellButtons(coin: coin)
                PortfolioCoinDetails(coin: coin)
                PortfolioViewLastTransactions()
            }
        }.navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                BackButton()
            }
        }
        
    }
}
