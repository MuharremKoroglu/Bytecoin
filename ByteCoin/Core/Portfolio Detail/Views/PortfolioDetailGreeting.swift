//
//  PortfolioCoinGreeting.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 6.03.2024.
//

import SwiftUI

struct PortfolioDetailGreeting: View {
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                DownloadImageAsync(url: coin.image ?? "",width: 70,height: 70)
                Text(coin.name?.capitalized ?? "")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                Text((coin.symbol?.uppercased() ?? ""))
                    .font(.headline)
                    .foregroundStyle(.gray)
            }.padding(.bottom, 10)
            HStack {
                Text(coin.totalPrice.convertCurrency())
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                Spacer()
                HStack {
                    Image(systemName: calculateTheProfit() > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10,height: 10)
                        .foregroundStyle(.white)
                    Text(calculateTheProfit().convertPrecentages())
                        .font(.headline)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }.padding(10)
                    .background(calculateTheProfit() > 0 ? .green : .red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
        }.padding()

    }
}

extension PortfolioDetailGreeting {
    
    private func calculateTheProfit () -> Double {
        let totalPrice = coin.totalPrice
        let percentageChange = (coin.priceChangePercentage24H ?? 0) / 100
        let previousPrice = totalPrice / (1 + percentageChange)
        let totalProfit = ((totalPrice - previousPrice) / previousPrice) * 100
        return totalProfit.isNaN ? 0 : totalProfit
    }
    
}


