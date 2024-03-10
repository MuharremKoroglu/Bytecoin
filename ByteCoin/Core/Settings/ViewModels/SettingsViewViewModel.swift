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
    
    private let authenticationManager = AuthenticationManager()
    private let databaseManager = DatabaseManager()
    
    
    func signOut () {
        
        Task {
            do {
                try authenticationManager.signOut()
                print("SİGN OUT BAŞARILI")
                isCompleted = true
            }catch {
                print("SİGN OUT OLUNAMADI : \(error)")
            }
        }
        
    }

    func deleteUserAccount () {
        
        Task {
            do {
                if let currentUser = try authenticationManager.currentUser() {
                    do {
                        try await databaseManager.deleteUserData(userId: currentUser.uid)
                        do {
                            try authenticationManager.deleteAccount()
                            print("KULLANICI SİLME BAŞARILI")
                            isCompleted = true
                        }catch {
                            print("KULLANICI SİLİNEMEDİ : \(error)")

                        }
                    }catch {
                        print("KULLANICI VERİLERİ SİLİNEMEDİ : \(error)")
                    }
                }
            }catch {
                print("KULLANICI SİLİNEMEDİ : \(error)")
            }
        }
    }
    
}
