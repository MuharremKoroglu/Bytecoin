//
//  ExchangeViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import Foundation
import FirebaseAuth

class CoinExchangeViewViewModel : ObservableObject {
    
    @Published var saveSuccessfully : Bool = false
    
    private var authManager = AuthenticationManager()
    private var dbManager = DatabaseManager()

    
    func editPortfolio (coin : AllCoinsDataResponseModel, coinAmount : Double, buttonType : ButtonsModel) {
        
        Task {
            do {
                let user = try authManager.getCurrentUser()
                do {
                    let portfolio = DatabasePortfolioModel(userId: user.uid, coinId: coin.id ?? "", coinAmount: buttonType == .buy ? coinAmount : -(coinAmount))
                    do {
                        try await dbManager.createPortfolio(portfolio: portfolio)
                        await MainActor.run {
                            saveSuccessfully = true
                        }
                        
                    }catch {
                        print("VERİ KAYDEDİLEMEDİ : \(error)")
                    }
                    
                }
            }catch {
                print("KULLANICI ALINAMADI : \(error)")
            }
        }

    }
    
    
    
    
}
