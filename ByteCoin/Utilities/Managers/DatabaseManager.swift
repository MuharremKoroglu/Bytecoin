//
//  DatabaseManager.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseManager : ObservableObject {
    
    private let usersCollection = Firestore.firestore().collection("users")
    
    private func getPortfolioDocument(userId : String, coinId: String) -> DocumentReference {
        return usersCollection.document(userId).collection(coinId).document(coinId)
    }
    
    func createPortfolio (portfolio : DatabasePortfolioModel) async throws{
        try getPortfolioDocument(userId: portfolio.userId, coinId: portfolio.coinId).setData(from: portfolio, merge: true)
    }
    
    func getPortfolio (userId : String, coinId: String) async throws -> DatabasePortfolioModel {
        try await getPortfolioDocument(userId: userId, coinId: coinId).getDocument(as: DatabasePortfolioModel.self)
    }
    
    func updateHoldingsInPortfolio (userId : String, coinId: String, newHoldingAmount : Double) async throws{
        let newHoldings : [String : Any] = [
            DatabasePortfolioModel.CodingKeys.coinAmount.rawValue : newHoldingAmount
        
        ]
        
        try await getPortfolioDocument(userId: userId, coinId: coinId).updateData(newHoldings)
    }
    
    
}
