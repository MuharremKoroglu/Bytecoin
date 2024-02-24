//
//  SearchBarView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import SwiftUI

struct SearchBarView: View {
    @StateObject var viewModel : MarketViewViewModel
    var body: some View {
        VStack {
            
            SearchBar(searchText: $viewModel.searchedText)
                
            
        }
    }
}
