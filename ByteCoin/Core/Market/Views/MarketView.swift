//
//  MarketView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import SwiftUI

struct MarketView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarView()
                AllCoinView()
            }.navigationTitle("Coin Market")
        }

    }
}

#Preview {
    MarketView()
}
