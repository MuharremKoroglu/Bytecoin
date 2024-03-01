//
//  CoinDetailViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import Foundation

class CoinDetailViewViewModel : ObservableObject {
    
    @Published var isCoinInPortfolio : Bool = false
    
    private var portfolioCoin : FirebaseDataModel? {
        didSet {
            isCoinInPortfolio = true
        }
    }
    private let authenticationManager = AuthenticationManager()
    private let databaseManager = DatabaseManager()
    
    func getCoinPortfolioInfo(coin : AllCoinsDataResponseModel) {
        Task {
            
            do {
                if let user = try authenticationManager.currentUser() {
                    
                    do {
                        let coin = try await databaseManager.getData(userId: user.uid, coinId: coin.id ?? "")
                        await MainActor.run {
                            portfolioCoin = coin
                        }
                    }catch {
                        print("CoinDetailViewViewModel'de getCoinPortfolioInfo fonksiyonunda COIN GETİRİLEMEDİ :\(error)")
                    }
                }
            }catch {
                print("CoinDetailViewViewModel'de getCoinPortfolioInfo fonksiyonunda KULLANICI BULUNAMADI :\(error)")
            }

        }
    }
    
    

}
