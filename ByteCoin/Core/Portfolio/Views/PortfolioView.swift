//
//  PortfolioView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import SwiftUI

struct PortfolioView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                
                SearchBarInPortfolioView()
                PortfolioCoinListView()
                
            }.navigationTitle("Portfolio")
        }
    }
}

