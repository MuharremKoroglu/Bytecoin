//
//  CoinDetailViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import Foundation

class CoinDetailViewViewModel : ObservableObject {
    
    @Published var coin : SingleCoinDataResponseModel?
    private var networkService = NetworkService()
    
    func getSingleCoin (id : String) {
        
        Task {
            let response = try await networkService.networkService(request: .getSingleCurrency(id: id), data: SingleCoinDataResponseModel.self)
            
            switch response {
            case .success(let coinData):
                await MainActor.run {
                    self.coin = coinData
                }
            case .failure(let failure):
                print("TEK COİN VERİSİ GETİRİLEMEDİ = \(failure)")
            }
        }
        
    }
    
    
    
}
