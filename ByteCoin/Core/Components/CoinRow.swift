//
//  CoinRow.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import SwiftUI

struct CoinRow: View {
    
    let coin: AllCoinsDataResponseModel
    
    var body: some View {
        HStack {
            Text(String(coin.marketCapRank ?? 1))
                .font(.caption)
                .foregroundStyle(.gray)
            DownloadImageAsync(url: coin.image ?? "",width: 32,height: 32)
            VStack(alignment : .leading, spacing: 3){
                Text(coin.name?.capitalized ?? "")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .padding(.leading, 4)
                Text(coin.symbol?.uppercased() ?? "")
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .padding(.leading, 4)
            }
            Spacer()
            VStack(alignment : .trailing, spacing: 3){
                Text(coin.currentPrice?.convertCurrency() ?? "0.0")
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
                Text(coin.priceChangePercentage24H?.convertPrecentages() ?? "-1.0")
                    .font(.caption)
                    .foregroundStyle(coin.priceChangePercentage24H ?? 1.0 > 0 ? .green : .red)
            }

        }.padding(.horizontal, 15)
            .padding(.vertical, 5)
    }
}
