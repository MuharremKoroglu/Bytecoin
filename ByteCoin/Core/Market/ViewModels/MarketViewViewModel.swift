//
//  MarketViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import Foundation

class MarketViewViewModel : ObservableObject {
    
    @Published var allCoins : [CryptoModel] = []
    
    private var networkService = NetworkService()
    
    func getAllCryptos () {
        
        Task {
            let response = try await networkService.networkService(request: .allCoinCurrencies, data: [CryptoModel].self)
            
            switch response {
            case .success(let allCurrencies):
                await MainActor.run {
                    self.allCoins = allCurrencies
                }
            case .failure(let failure):
                print("MARKET COİN VERİLERİ GETİRİLEMEDİ : \(failure)")
            }
            
        }
        
    }
    
    
}
