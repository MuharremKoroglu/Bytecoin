//
//  ByteCoinApp.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import SwiftUI
import FirebaseCore

@main
struct ByteCoinApp: App {
        
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
