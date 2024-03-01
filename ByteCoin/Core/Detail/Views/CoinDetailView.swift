//
//  CoinDetailView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import SwiftUI

struct CoinDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = CoinDetailViewViewModel()
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ScrollView(.vertical,showsIndicators: false) {
                VStack {
                    CoinPriceLineChartView(coin: coin)
                        .frame(height: size.height * 0.5)
                    BuyOrSellButtonsView(viewModel: viewModel, coin: coin)
                    CoinOverViewView(coinComesFromMarketView: coin)
                    CoinAdditionalDetailsView(coinComesFromMarketView: coin)
                }
            }.navigationTitle(coin.name ?? "Bitcoin")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .foregroundStyle(.appMain)
                            .padding(.all, 10)
                            .bold()
                        
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    HStack {
                        Text(coin.symbol?.uppercased() ?? "")
                            .font(.callout)
                            .foregroundStyle(.gray)
                        DownloadImageAsync(url: coin.image ?? "")
                    }
                }
            }
        }

    }
}
