//
//  MarketViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import Foundation

@MainActor
class MarketViewViewModel : ObservableObject {
    
    @Published var allCoins : [AllCoinsDataResponseModel] = []
    @Published var portfolioCoins : [AllCoinsDataResponseModel] = []
    @Published var searchedText : String = ""
    
    var filteredCoins: [AllCoinsDataResponseModel] {
        return self.filterCoins()
    }
    
    private let dbManager = DatabaseManager()
    private let authManager = AuthenticationManager()
    private let networkService = NetworkService()
    
    init(){
        getAllCryptos()
    }
    
    func getAllCryptos() {
        Task {
            do {
                
                guard let user = try authManager.currentUser() else {
                    print("KULLANICI BULUNAMADI")
                    return
                }

                let response = try await networkService.networkService(
                    request: .allCoinCurrencies,
                    data: [AllCoinsDataResponseModel].self
                )

                switch response {
                case .success(var allCurrencies):
                    
                    let userPortfolio = try await dbManager.getMultipleDocumentData(
                        userId: user.uid
                    )
                    
                    
                    allCurrencies = allCurrencies.map { coin in
                        if let portfolioCoin = userPortfolio.first(where: { $0.coinId == coin.id }) {
                            return coin.updateHolgins(amount: portfolioCoin.coinAmount ?? 0)
                        }else {
                            return coin.updateHolgins(amount: 0)
                        }
                    }
                    
                    var portfolioCoins = allCurrencies.filter({$0.currentCoinAmount != 0})

                    self.allCoins = allCurrencies
                    self.portfolioCoins = portfolioCoins
                    
                    print("COİN LİSTESİ : \(portfolioCoins)")
                    
                case .failure(let failure):
                    print("MARKET COIN DATA COULD NOT BE RETRIEVED: \(failure)")
                    return
                }
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
    private func filterCoins () -> [AllCoinsDataResponseModel] {
        if searchedText.isEmpty {
            return allCoins
        } else {
            return allCoins.filter { $0.name!.lowercased().contains(searchedText.lowercased()) || $0.symbol!.lowercased().contains(searchedText.lowercased()) }
        }
    }
    
}
