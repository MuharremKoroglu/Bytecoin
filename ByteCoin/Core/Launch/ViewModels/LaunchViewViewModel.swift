//
//  LaunchViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 5.03.2024.
//

import Foundation

@MainActor
class LaunchViewViewModel : ObservableObject {
    
    @Published var userId : String = ""
    @Published var isAuthenticated : Bool = false
    
    private let authenticationManager = AuthenticationManager()
    
    func signIn () async {
        
        do {
            let user = try authenticationManager.currentUser()
            if user != nil {
                userId = user?.uid ?? ""
                isAuthenticated = true
                print("CURRENT USER GİRİŞ YAPTI : \(userId)")
            }else {
                let user = try await authenticationManager.signInAnonymously()
                userId = user?.uid ?? ""
                isAuthenticated = true
                print("ANON USER GİRİŞ YAPTI : \(userId)")
            }
        }catch {
            isAuthenticated = false
            print("FIREBASE KULLANICI GİRİŞİNDE HATA : \(error)")
        }
        
    }
}
