//
//  SettingsDeleteAccountView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 9.03.2024.
//

import SwiftUI

struct AccountSectionView: View {
    
    @EnvironmentObject private var launchViewModel : LaunchViewViewModel
    
    @StateObject var settingsViewModel : SettingsViewViewModel
    
    @State private var alertIsPresenting : Bool = false
    
    var body: some View {
        Section {
            
            Text("USER : \(launchViewModel.userId)")
                .font(.system(size: 14,weight: .semibold))
            
            Button("Sign Out") {
                settingsViewModel.signOut()
            }
            
            Button(role: .destructive) {
                
                alertIsPresenting.toggle()
                
            } label: {
                Text("Delete My Account")
                
            }.alert("Delete Account", isPresented: $alertIsPresenting, actions: {
                Button("Cancel",role: .cancel) {}
                
                Button("Delete", role: .destructive) {
                    
                    settingsViewModel.deleteUserAccount()
                    
                }
            }, message: {
                Text("Are you sure you want your account to be deleted? This action cannot be undone!")
            })
            
        } header: {
            Text("Account")
            
        }.fullScreenCover(isPresented: $settingsViewModel.isCompleted) {
            GoodByeView()
        }
    }
}

