//
//  DatabaseManager.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseManager {
    
    
    private let collection = Firestore.firestore().collection("users")
    
    private func getUsersDocumentReference(documentId : String) -> DocumentReference {
        return collection.document(documentId)
    }
    
    private func getCollectionReference (documentId : String, collectionName : FirebaseCollectionName) -> CollectionReference {
        return collection.document(documentId).collection(collectionName.rawValue)
    }
    
    private func getDocumentReference (documentId : String, collectionName : FirebaseCollectionName, collectionId : String) -> DocumentReference {
        return collection.document(documentId).collection(collectionName.rawValue).document(collectionId)
    }
    
    func createData <T: Encodable> (userId : String, collectionName : FirebaseCollectionName, collectionId : String ,data : T) async throws{
        try getDocumentReference(documentId: userId,collectionName: collectionName ,collectionId: collectionId).setData(from: data, merge: false)
    }
    
    func getSingleData <T: Decodable> (userId : String,collectionName: FirebaseCollectionName, collectionId : String, objectType: T.Type) async throws -> T{
        try await getDocumentReference(documentId: userId,collectionName: collectionName ,collectionId: collectionId).getDocument(as: objectType.self)
    }
    
    func getMultipleData <T : Decodable> (userId: String,collectionName : FirebaseCollectionName, objectType: T.Type) async throws -> [T] {
        let userCollectionRef = getCollectionReference(documentId: userId, collectionName: collectionName)
        let querySnapshot = try await userCollectionRef.getDocuments()
        var dataModels: [T] = []
        for document in querySnapshot.documents {
            if let dataModel = try? document.data(as: objectType.self) {
                dataModels.append(dataModel)
            }
        }
        return dataModels
    }

    
    func updateData (userId : String, collectionName : FirebaseCollectionName, collectionId : String, newValue : Double) async throws{
        
        let coinAmountData : [String : Any] = [
            FirebasePortfolioDataModel.CodingKeys.coinAmount.rawValue : newValue
        ]
        
        try await getDocumentReference(documentId: userId, collectionName: collectionName, collectionId: collectionId).updateData(coinAmountData)
        
    }
    
    func deleteData (userId : String, collectionName : FirebaseCollectionName,  coinId : String) async throws{
        try await getDocumentReference(documentId: userId, collectionName: collectionName, collectionId: coinId).delete()
    }
    
    func deleteUserData (userId : String) async throws{
        
        for collectionName in FirebaseCollectionName.allCases {
            let subcollectionRef = getCollectionReference(documentId: userId, collectionName: collectionName)
            let documents = try await subcollectionRef.getDocuments().documents
            for document in documents {
                try await document.reference.delete()
            }
        }
    
    }
    

}
