//
//  SearchBarView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    
    var body: some View {
        VStack {
            SearchBar(searchText: $homeViewModel.marketCoinSearchedText)                
        }
    }
}
