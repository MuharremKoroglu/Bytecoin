//
//  HomeScreenViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import Foundation

class HomeViewViewModel : ObservableObject {
    
    @Published var recommendedCoins : [CryptoModel] = []
    @Published var allUsers : [UserResult] = []
    
    private var networkService = NetworkService()
    
    func getRecommendedCryptoCurrencies () {
                
        Task {
            let response = try await networkService.networkService(request: APIRequestService.allCoinCurrencies, data: [CryptoModel].self)
            
            switch response {
            case .success(let allCryptos):
                await MainActor.run {
                    self.recommendedCoinsList(coins:allCryptos)
                }
            case .failure(let failure):
                print("COİN VERİLERİ GETİRİLEMEDİ : \(failure)")
            }
        }
        
    }
    
    func getAllUser () {
        
        Task {
            let response = try await networkService.networkService(request: APIRequestService.allUsers, data: UserModel.self)
            
            switch response {
            case .success(let allUsers):
                await MainActor.run {
                    self.allUsers = allUsers.results ?? []
                }
            case .failure(let failure):
                print("KULLANICI VERİLERİ GETİRİLEMEDİ : \(failure)")
            }

        }
    }
    
    private func recommendedCoinsList (coins : [CryptoModel]) {
        let sortedCoins = coins.sorted(by: {$0.priceChangePercentage24H ?? 1.0 > $1.priceChangePercentage24H ?? 0.0})
        self.recommendedCoins = Array(sortedCoins.prefix(5))
    }
    
}

