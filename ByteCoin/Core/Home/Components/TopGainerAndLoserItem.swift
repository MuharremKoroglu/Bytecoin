//
//  RecommendedToBuy.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct TopGainerAndLoserItem: View {
    
    let coin : CryptoModel
    
    var body: some View {
        VStack (alignment: .leading,spacing: 8){
            HStack(spacing : 10) {
                AsyncImage(url: URL(string: coin.image ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35,height: 35)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(.placeholder)
                        .frame(width: 35,height: 35)
                }
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

#Preview {
    TopGainerAndLoserItem(coin: CryptoModel(id: "", symbol: "BTC", name: "Bitcoin", image: "btc", currentPrice: 51102, marketCap: 1, marketCapRank: 1, fullyDilutedValuation: 1, totalVolume: 1, high24H: 1, low24H: 1, priceChange24H: 1, priceChangePercentage24H: 1, marketCapChange24H: 1, marketCapChangePercentage24H: 1, circulatingSupply: 1, totalSupply: 1, maxSupply: 1, ath: 1, athChangePercentage: 1, athDate: "", atl: 1, atlChangePercentage: 1, atlDate: "", roi: Roi(times: 1, currency: "", percentage: 1), lastUpdated: "", sparklineIn7D: SparklineIn7D(price: [1]), priceChangePercentage24HInCurrency: 1))
}
