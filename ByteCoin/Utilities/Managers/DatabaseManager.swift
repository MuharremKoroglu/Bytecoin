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
    
    private func getUserProfileCollectionReference (documentId : String) -> CollectionReference {
        return getUsersDocumentReference(documentId: documentId).collection("user_profile")
    }
    
    private func getUserProfileDocumentReference (documentId : String, collectionId : String) -> DocumentReference {
        return getUserProfileCollectionReference(documentId: documentId).document(collectionId)
    }
    
    func createData <T: Encodable> (userId : String, collectionId : String ,data : T) async throws{
        try getUserProfileDocumentReference(documentId: userId, collectionId: collectionId).setData(from: data, merge: false)
    }
    
    func getSingleData <T: Decodable> (userId : String, collectionId : String, objectType: T.Type) async throws -> T{
        try await getUserProfileDocumentReference(documentId: userId, collectionId: collectionId).getDocument(as: objectType.self)
    }
    
    func getMultipleData <T : Decodable> (userId: String, query: FirebaseQueryConditions? = nil ,objectType: T.Type) async throws -> [T] {
        var userCollectionRef: Query = getUserProfileCollectionReference(documentId: userId)
        
        if let query = query {
            switch query {
            case .portfolio:
                userCollectionRef = userCollectionRef.whereField(query.field, isNotEqualTo: query.value)
            case .watchList:
                userCollectionRef = userCollectionRef.whereField(query.field, isEqualTo: query.value)
            }
        }
        
        let querySnapshot = try await userCollectionRef.getDocuments()
        var dataModels: [T] = []
        for document in querySnapshot.documents {
            if let dataModel = try? document.data(as: objectType.self) {
                dataModels.append(dataModel)
            }
        }
        return dataModels
    }

    
    func updateData (userId : String,collectionId : String, field: String, newValue : Any) async throws{
        
        let updatedData : [String : Any] = [
            field : newValue
        ]
        
        try await getUserProfileDocumentReference(documentId: userId, collectionId: collectionId).updateData(updatedData)

    }
    
    func deleteData (userId : String, collectionId : String) async throws{
        try await getUserProfileDocumentReference(documentId: userId,collectionId: collectionId).delete()
    }
    
    func deleteUserData (userId : String) async throws{
        
        let subcollectionRef = getUserProfileCollectionReference(documentId: userId)
        let documents = try await subcollectionRef.getDocuments().documents
        for document in documents {
            try await document.reference.delete()
        }

    }
    
}
