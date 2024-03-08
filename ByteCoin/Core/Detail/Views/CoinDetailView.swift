//
//  CoinDetailView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import SwiftUI

struct CoinDetailView: View {
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ScrollView(.vertical,showsIndicators: false) {
                VStack {
                    CoinPriceLineChartView(coin: coin)
                        .frame(height: size.height * 0.5)
                    BuyOrSellButtonsView(coin: coin)
                    CoinOverViewView(coin: coin)
                    CoinAdditionalDetailsView(coin: coin)
                }
            }.navigationTitle(coin.name?.capitalized ?? "Bitcoin")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    BackButton()
                }
                ToolbarItem(placement: .topBarTrailing){
                    AddWatchListSharedView(coin: coin)
                }
            }
        }

    }
}
