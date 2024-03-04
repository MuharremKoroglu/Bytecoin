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
            Text(coin.name?.capitalized ?? "")
                .font(.title)
                .fontWeight(.semibold)
            Text(coin.symbol?.uppercased() ?? "")
                .font(.subheadline)
                .foregroundStyle(.gray)
            Text(coin.currentPrice?.convertCurrency() ?? "")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top,5)
        }.padding(.vertical, 10)
    }
}

