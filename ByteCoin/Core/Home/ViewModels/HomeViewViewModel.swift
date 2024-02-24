//
//  HomeScreenViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import Foundation

class HomeViewViewModel : ObservableObject {
    
    @Published var topGainerCoins : [CryptoModel] = []
    @Published var topLoserCoins : [CryptoModel] = []
    @Published var allUsers : [UserResult] = []
    
    private var networkService = NetworkService()
    
    func getAllCurrencies () {
                
        Task {
            let response = try await networkService.networkService(request: APIRequestService.allCoinCurrencies, data: [CryptoModel].self)
            
            switch response {
            case .success(let allCryptos):
                await MainActor.run {
                    self.topGainerCoinList(coins:allCryptos)
                    self.topLoserCoinList(coins: allCryptos)
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
    
    private func topGainerCoinList (coins : [CryptoModel]) {
        let sortedCoins = coins.sorted(by: {$0.priceChangePercentage24H ?? 1.0 > $1.priceChangePercentage24H ?? 0.0})
        self.topGainerCoins = Array(sortedCoins.prefix(5))
    }
    
    private func topLoserCoinList (coins : [CryptoModel]) {
        let sortedCoins = coins.sorted(by: {$0.priceChangePercentage24H ?? 1.0 < $1.priceChangePercentage24H ?? 0.0})
        self.topLoserCoins = Array(sortedCoins.prefix(5))
    }
    
}

