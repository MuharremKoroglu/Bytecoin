//
//  HomeScreenViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import Foundation

class HomeViewViewModel : ObservableObject {
    
    @Published var topGainerCoins : [AllCoinsDataResponseModel] = []
    @Published var topLoserCoins : [AllCoinsDataResponseModel] = []
    @Published var allUsers : [UserResult] = []
    
    private var networkService = NetworkService()
    
    init() {
        getAllCurrencies()
        getAllUser()
    }
    
    func getAllCurrencies () {
                
        Task {
            let response = try await networkService.networkService(request: APIRequestService.allCoinCurrencies, data: [AllCoinsDataResponseModel].self)
            
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
            let response = try await networkService.networkService(request: APIRequestService.allUsers, data: AllUserDataResponseModel.self)
            
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
    
    private func topGainerCoinList (coins : [AllCoinsDataResponseModel]) {
        let sortedCoins = coins.sorted(by: {$0.priceChangePercentage24H ?? 1.0 > $1.priceChangePercentage24H ?? 0.0})
        self.topGainerCoins = Array(sortedCoins.prefix(5))
    }
    
    private func topLoserCoinList (coins : [AllCoinsDataResponseModel]) {
        let sortedCoins = coins.sorted(by: {$0.priceChangePercentage24H ?? 1.0 < $1.priceChangePercentage24H ?? 0.0})
        self.topLoserCoins = Array(sortedCoins.prefix(5))
    }
    
}

