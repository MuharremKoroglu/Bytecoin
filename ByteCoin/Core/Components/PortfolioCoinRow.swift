//
//  PortfolioCoinRow.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import SwiftUI

struct PortfolioCoinRow: View {
    
    let coin: AllCoinsDataResponseModel
    
    var body: some View {
        HStack {
            DownloadImageAsync(url: coin.image ?? "",width: 32,height: 32)
            VStack(alignment : .leading, spacing: 3){
                Text(coin.name ?? "")
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
            Text(coin.currentCoinAmount?.convertDoubleToStringFromInt() ?? "")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            Spacer()
            Text(calculateTotalPrice().convertWithAbbreviations())
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            

        }.padding(.horizontal, 15)
            .padding(.vertical, 5)
    }
}

extension PortfolioCoinRow {
    
    private func calculateTotalPrice () -> Double {
        
        guard let coinPrice = coin.currentPrice else {
            return 0
        }
        
        guard let coinHoldings = coin.currentCoinAmount else {
            return 0
        }
        
        return coinPrice * coinHoldings
        
    }
    
}
