//
//  PortfolioViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import Foundation


class PortfolioViewViewModel : ObservableObject {
    
    @Published var portfolio : [DatabasePortfolioModel] = []
    @Published var searchedText : String = ""
    
    
    
    private var dbManager = DatabaseManager()
    private var authManager = AuthenticationManager()
    
    func getPortfolio () {
        
        Task {
            do {
                let currentUser = try authManager.getCurrentUser()
                do {
                    let portfolio = try await dbManager.getPortfolio(userId: currentUser.uid, coinId: "ethereum")
                    await MainActor.run {
                        self.portfolio.append(portfolio)
                        print(self.portfolio)
                    }
                }catch {
                    print("PORTFOLYA FİREBASE'DEN GELMEDİ : \(error)")
                }
                
            }catch {
                print("KULLANICI ALINAMADI : \(error)")
            }
        }
    }
    
    
    
    
}
