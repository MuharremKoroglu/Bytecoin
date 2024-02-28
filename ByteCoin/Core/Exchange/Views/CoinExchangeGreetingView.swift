//
//  CoinExchangeGreetingView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangeGreetingView: View {
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        VStack {
            DownloadImageAsync(url: coin.image ?? "",width: 100, height: 100)
            Text(coin.name ?? "")
                .font(.title)
                .fontWeight(.semibold)
            Text(coin.symbol?.uppercased() ?? "")
                .font(.subheadline)
                .foregroundStyle(.gray)
        }.padding(.vertical, 10)
    }
}

