//
//  PortfolioView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarInPortfolioView()
                
                if homeViewModel.portfolioCoins.isEmpty {
                    PortfolioEmptyView()
                }else {
                    PortfolioCoinListView()
                }

            }.navigationTitle("Portfolio")
        }
    }
}

