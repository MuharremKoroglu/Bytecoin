//
//  HomeScreenViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import Foundation

class HomeScreenViewModel : ObservableObject {
    
    @Published var allCurrencies : [CryptoModel] = []
    private var networkService = NetworkService()
    
    func getAllCryptoCurrencies () {
                
        Task {
            
            let response = try await networkService.networkService(request: APIRequestService.allCoinCurrencies, data: [CryptoModel].self)
            
            switch response {
            case .success(let allCryptos):
                await MainActor.run {
                    self.allCurrencies = allCryptos
                }
            case .failure(let failure):
                print("VERİ GETİRİLEMEDİ : \(failure)")
            }

        }

    }
}

