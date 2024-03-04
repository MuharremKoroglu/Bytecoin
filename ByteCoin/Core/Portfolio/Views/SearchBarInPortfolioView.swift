//
//  SearchBarInPortfolioView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import SwiftUI

struct SearchBarInPortfolioView: View {
    
    @EnvironmentObject var homeViewModel : HomeViewViewModel

    var body: some View {
        VStack {
            SearchBar(searchText: $homeViewModel.portfolioCoinSearchedText)
        }
    }
}
