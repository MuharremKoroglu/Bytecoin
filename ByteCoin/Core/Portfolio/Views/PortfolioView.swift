//
//  PortfolioView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import SwiftUI

struct PortfolioView: View {
    
    @StateObject private var viewModel = PortfolioViewViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarInPortfolioView(viewModel: viewModel)
                PortfolioCoinListView()
                
            }.navigationTitle("Your Portfolio")
            
        }
    }
}

