//
//  MarketView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import SwiftUI

struct MarketView: View {
    
    @StateObject private var viewModel = MarketViewViewModel()
    
    @State var searchedText : String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarView(searchedText: $searchedText)
                AllCoinView(viewModel: viewModel)
            }.navigationTitle("Coin Market")
                .onAppear{
                    viewModel.getAllCryptos()
                }
        }

    }
}

#Preview {
    MarketView()
}
