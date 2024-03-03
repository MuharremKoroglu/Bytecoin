//
//  CoinDetailViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import Foundation

@MainActor
class CoinDetailViewViewModel : ObservableObject {
    
    @Published var isCoinInPortfolio : Bool = false
    
    
    private let authenticationManager = AuthenticationManager()
    private let databaseManager = DatabaseManager()
    
    func getCoinPortfolioInfo(coin : AllCoinsDataResponseModel) {
        Task {
            
            do {
                if let user = try authenticationManager.currentUser() {
                    
                    do {
                        let coin = try await databaseManager.getSingleDocumentData(userId: user.uid, coinId: coin.id ?? "")
                        isCoinInPortfolio = true
                        
                    }catch {
                        isCoinInPortfolio = false
                        print("CoinDetailViewViewModel'de getCoinPortfolioInfo fonksiyonunda COIN GETİRİLEMEDİ :\(error)")
                    }
                }
            }catch {
                print("CoinDetailViewViewModel'de getCoinPortfolioInfo fonksiyonunda KULLANICI BULUNAMADI :\(error)")
            }

        }
    }
    
    

}
