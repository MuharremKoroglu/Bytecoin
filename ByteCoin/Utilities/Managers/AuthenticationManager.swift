//
//  AuthenticationManager.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import Foundation
import FirebaseAuth

class AuthenticationManager : ObservableObject {

    
    func currentUser() throws -> User? {
        let user = Auth.auth().currentUser
        return user
    }
    
    func signInAnonymously() async throws -> User?{
        let authResult = try await Auth.auth().signInAnonymously()
        let user = authResult.user
        return user
    }
    
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
    func deleteAccount() throws{
        guard let user = try self.currentUser() else {
            return
        }
        user.delete()
    }
    
    
}


