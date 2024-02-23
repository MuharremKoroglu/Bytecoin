//
//  RecommendedToBuy.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct RecommendedToBuy: View {
    
    let coin : CryptoModel
    
    var body: some View {
        VStack (alignment: .leading){
            HStack(spacing : 10) {
                AsyncImage(url: URL(string: coin.image ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(.placeholder)
                        .frame(width: 50,height: 50)
                }
                Text(coin.symbol?.uppercased() ?? "Test")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
            }
            HStack(alignment: .bottom) {
                VStack(alignment: .leading){
                    Text("Current Price")
                        .font(.callout)
                        .foregroundStyle(.gray)
                    Text(coin.currentPrice?.convertCurrency() ?? "0.0")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                HStack(spacing : 5){
                    Image(systemName: coin.priceChangePercentage24H ?? 1.0 > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12,height: 12)
                        .foregroundStyle(coin.priceChangePercentage24H ?? 1.0 > 0 ? .green : .red)
                    
                    Text(coin.priceChangePercentage24H?.convertPrecentages() ?? "0.0")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(coin.priceChangePercentage24H ?? 1.0 > 0 ? .green : .red)
                }.padding(.leading, 15)
            }
            
        }.padding(.horizontal, 15)
            .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.regularMaterial)
        )
    }
}
