//
//  RecommendedToBuy.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct TopGainerAndLoserItem: View {
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        VStack (alignment: .leading,spacing: 8){
            HStack(spacing : 10) {
                DownloadImageAsync(url: coin.image ?? "",width: 35,height: 35)
                Text(coin.symbol?.uppercased() ?? "Test")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
            }
            HStack(alignment: .bottom) {
                VStack(alignment: .leading){
                    Text("Current Price")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text(coin.currentPrice?.convertCurrency() ?? "0.0")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                Spacer()
                HStack(spacing : 5){
                    Image(systemName: coin.priceChangePercentage24H ?? 1.0 > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 7,height: 7)
                        .foregroundStyle(coin.priceChangePercentage24H ?? 1.0 > 0 ? .green : .red)
                    
                    Text(coin.priceChangePercentage24H?.convertPrecentages() ?? "0.0")
                        .font(.caption)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .foregroundStyle(coin.priceChangePercentage24H ?? 1.0 > 0 ? .green : .red)
                }
            }
            
        }.frame(width: 170)
        .padding(.horizontal, 15)
            .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.regularMaterial)
        )
    }
}

