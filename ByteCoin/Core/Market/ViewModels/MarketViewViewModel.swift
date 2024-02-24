//
//  MarketViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import Foundation

class MarketViewViewModel : ObservableObject {
    
    @Published var allCoins : [CryptoModel] = []
    @Published var searchedText : String = ""
    
    var filteredCoins: [CryptoModel] {
        return self.filterCoins()
    }
    
    private var networkService = NetworkService()
    
    func getAllCryptos () {
        
        Task {
            let response = try await networkService.networkService(request: .allCoinCurrencies, data: [CryptoModel].self)
            
            switch response {
            case .success(let allCurrencies):
                await MainActor.run {
                    self.allCoins = allCurrencies
                    print(allCoins)
                }
            case .failure(let failure):
                print("MARKET COİN VERİLERİ GETİRİLEMEDİ : \(failure)")
            }
        }
        
    }
    
    private func filterCoins () -> [CryptoModel] {
        if searchedText.isEmpty {
            return allCoins
        } else {
            return allCoins.filter { $0.name!.lowercased().contains(searchedText.lowercased()) || $0.symbol!.lowercased().contains(searchedText.lowercased()) }
        }
    }
    
}
