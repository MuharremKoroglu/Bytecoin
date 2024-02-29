//
//  PortfolioCoinListView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import SwiftUI

struct PortfolioCoinListView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Coin")
                Spacer()
                Text("Amount")
                Spacer()
                Text("Total")
            }.font(.caption)
                .foregroundStyle(.gray)
                .padding(.horizontal,15)
            ScrollView(.vertical, showsIndicators: false) {
                Text("COIN LIST")
            }
            
        }
    }
}

#Preview {
    PortfolioCoinListView()
}
