//
//  CoinDetailView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import SwiftUI

struct CoinDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = CoinDetailViewViewModel()
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack {
                CoinOverViewView(coinComesFromMarketView: coin, coinComesFromViewModel: viewModel.coin ?? SingleCoinDataResponseModel(id: "", symbol: "", name: "", hashingAlgorithm: "", description: Description(en: ""), links: ImportantLinks(homepage: [""], whitepaper: "")))
                CoinAdditionalDetailsView(coinComesFromMarketView: coin, coinComesFromViewModel: viewModel.coin ?? SingleCoinDataResponseModel(id: "", symbol: "", name: "", hashingAlgorithm: "", description: Description(en: ""), links: ImportantLinks(homepage: [""], whitepaper: "")))
            }
        }.onAppear {
            viewModel.getSingleCoin(id: coin.id ?? "bitcoin")
        }
        .navigationTitle(coin.name ?? "Bitcoin")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundStyle(.appMain)
                        .padding(.all, 10)
                        .bold()
                    
                }
            }
            ToolbarItem(placement: .topBarTrailing){
                HStack {
                    Text(coin.symbol?.uppercased() ?? "")
                        .font(.callout)
                        .foregroundStyle(.gray)
                    DownloadImageAsync(url: coin.image ?? "")
                }
            }
        }
    }
}

#Preview {
    CoinDetailView(coin: AllCoinsDataResponseModel(id: "", symbol: "BTC", name: "Bitcoin", image: "btc", currentPrice: 51102, marketCap: 1, marketCapRank: 1, fullyDilutedValuation: 1, totalVolume: 1, high24H: 1, low24H: 1, priceChange24H: 1, priceChangePercentage24H: 1, marketCapChange24H: 1, marketCapChangePercentage24H: 1, circulatingSupply: 1, totalSupply: 1, maxSupply: 1, ath: 1, athChangePercentage: 1, athDate: "", atl: 1, atlChangePercentage: 1, atlDate: "", roi: Roi(times: 1, currency: "", percentage: 1), lastUpdated: "", sparklineIn7D: SparklineIn7D(price: [1]), priceChangePercentage24HInCurrency: 1))
}
