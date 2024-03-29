//
//  PortfolioDetailView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 6.03.2024.
//

import SwiftUI

struct PortfolioDetailView: View {
    
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    @StateObject private var viewModel = PortfolioDetailViewViewModel()
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(alignment: .leading) {
                PortfolioDetailGreeting(coin: coin)
                PortfolioDetailBuyOrSellButtons(coin: coin)
                PortfolioCoinDetails(coin: coin)
                PortfolioDetailLastTransactions(viewModel: viewModel)
            }
        }.overlay(alignment: .center, content: {
            if homeViewModel.startProgressIndicator {
                CustomProgressView()
            }
            
        })
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                BackButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                AddWatchListSharedView(coin: coin)
            }
        }
        
    }
}
