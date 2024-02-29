//
//  AuthenticationManager.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import Foundation
import FirebaseAuth

class AuthenticationManager : ObservableObject {
    
    func getCurrentUser () throws -> User {
        guard let user = Auth.auth().currentUser else {
            throw AuthenticationError.currentUserNotFound
        }
        return user
    }
    

    func signInAnonymously () async throws{
        try await Auth.auth().signInAnonymously()
    }
    
    
    func signOut () throws{
        try Auth.auth().signOut()
    }
    
    func deleteUser () async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthenticationError.currentUserNotFound
        }
        try await user.delete()
    }
    
}

enum AuthenticationError : Error {
    case currentUserNotFound
}
