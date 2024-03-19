//
//  TopGainerAndLosersView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 18.03.2024.
//

import SwiftUI

struct TopGainerAndLosersSharedView: View {
    
    let title : String
    let coinList : [AllCoinsDataResponseModel]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(coinList,id: \.id) { coin in
                        NavigationLink {
                            CoinDetailView(coin: coin)
                        } label: {
                            TopGainerAndLoserItem(coin: coin)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }.padding(.horizontal, 15)
    }
}
