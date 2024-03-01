//
//  DatabaseManager.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class DatabaseManager : ObservableObject {
    
    
    private let collection = Firestore.firestore().collection("users")
    
    private func getDocument (documentId : String, collectionId : String) -> DocumentReference {
        return collection.document(documentId).collection(collectionId).document(collectionId)
    }
    
    func createData (userId : String,data : FirebaseDataModel) async throws{
        try getDocument(documentId: userId, collectionId: data.coinId).setData(from: data, merge: false)
    }
    
    func getData (userId : String, coinId : String) async throws -> FirebaseDataModel{
        try await getDocument(documentId: userId, collectionId: coinId).getDocument(as: FirebaseDataModel.self)
    }
    
    func updateData (userId : String, coinId : String, newValue : Double) async throws{
        
        let coinAmountData : [String : Any] = [
            FirebaseDataModel.CodingKeys.coinAmount.rawValue : newValue
        ]
        
        try await getDocument(documentId: userId, collectionId: coinId).updateData(coinAmountData)
        
    }
    
    func deleteData (userId : String, coinId : String) async throws{
       try await getDocument(documentId: userId, collectionId: coinId).delete()
    }
    

}
