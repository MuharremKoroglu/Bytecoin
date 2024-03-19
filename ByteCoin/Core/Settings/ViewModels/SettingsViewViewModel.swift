//
//  SettingsViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 9.03.2024.
//

import Foundation

@MainActor
class SettingsViewViewModel : ObservableObject {
    
    @Published var isCompleted : Bool = false
    @Published var isProgressing : Bool = false
    
    private let authenticationManager = AuthenticationManager()
    private let databaseManager = DatabaseManager()
    
    
    func signOut () {
        
        Task {
            do {
                isProgressing = true
                try authenticationManager.signOut()
                isProgressing = false
                isCompleted = true
            }catch {
                print("Sign out could not be achieved : \(error)")
            }
        }
        
    }

    func deleteUserAccount () {
        
        Task {
            do {
                isProgressing = true
                if let currentUser = try authenticationManager.currentUser() {
                    do {
                        try await databaseManager.deleteUserData(userId: currentUser.uid)
                        do {
                            try authenticationManager.deleteAccount()
                            isProgressing = false
                            isCompleted = true
                        }catch {
                            print("Failed to clear user session log : \(error)")
                        }
                    }catch {
                        print("User information could not be cleared : \(error)")
                    }
                }
            }catch {
                print("Current user not found : \(error)")
            }
        }
    }
    
}
