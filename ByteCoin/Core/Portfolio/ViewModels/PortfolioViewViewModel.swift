//
//  PortfolioViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import Foundation


class PortfolioViewViewModel : ObservableObject {
    
    @Published var portfolioCoins : [AllCoinsDataResponseModel] = []
    @Published var searchedText : String = ""
    
    var filteredCoins: [AllCoinsDataResponseModel] {
        return self.filterCoins()
    }
    
    private let authManager = AuthenticationManager()
    private let dbManager = DatabaseManager()
    private let networkService = NetworkService()
    
    func getPortfolioCoins () {
        
        Task {
            
            guard let user = try authManager.currentUser() else {
                print("KULLANICI BULUNAMADI")
                return
            }

            let response = try await networkService.networkService(
                request: .allCoinCurrencies,
                data: [AllCoinsDataResponseModel].self
            )
            
            switch response {
            case .success(let allCurrencies):
                await MainActor.run {
                    portfolioCoins = allCurrencies
                }
//                for currency in allCurrencies {
//                    let firebaseData = try await dbManager.getDataForUser(userId: user.uid, coinId: currency.id ?? "")
//                    let updatedCoinAmount = currency.updateHolgins(amount: firebaseData. ?? 0)
//                    await MainActor.run {
//                        if updatedCoinAmount.currentCoinAmount != 0 {
//                            portfolioCoins.append(updatedCoinAmount)
//                        }
//                        
//                    }
//                }

            case .failure(let failure):
                print("COİN VERİLERİ GETİRİLEMEDİ : \(failure)")
            }
        }
    }
    
    private func filterCoins () -> [AllCoinsDataResponseModel] {
        if searchedText.isEmpty {
            return portfolioCoins
        } else {
            return portfolioCoins.filter { $0.name!.lowercased().contains(searchedText.lowercased()) || $0.symbol!.lowercased().contains(searchedText.lowercased()) }
        }
    }
    
}
