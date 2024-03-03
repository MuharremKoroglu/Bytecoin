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
    
    private func getCollection (documentId : String) -> CollectionReference {
        return collection.document(documentId).collection("portfolio")
    }
    
    private func getDocument (documentId : String, collectionId : String) -> DocumentReference {
        return collection.document(documentId).collection("portfolio").document(collectionId)
    }
    
    func createData (userId : String,data : FirebaseDataModel) async throws{
        try getDocument(documentId: userId, collectionId: data.coinId).setData(from: data, merge: false)
    }
    
    func getSingleDocumentData (userId : String, coinId : String) async throws -> FirebaseDataModel{
        try await getDocument(documentId: userId, collectionId: coinId).getDocument(as: FirebaseDataModel.self)
    }
    
    func getMultipleDocumentData(userId: String) async throws -> [FirebaseDataModel] {
        let userCollectionRef = getCollection(documentId: userId)
        let querySnapshot = try await userCollectionRef.getDocuments()
        var dataModels: [FirebaseDataModel] = []
        for document in querySnapshot.documents {
            if let dataModel = try? document.data(as: FirebaseDataModel.self) {
                dataModels.append(dataModel)
            }
        }
        return dataModels
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
