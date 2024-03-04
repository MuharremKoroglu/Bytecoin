//
//  ContentView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import SwiftUI

struct HomeView: View {
        
    var body: some View {
        NavigationStack {
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing: 10) {
                    WelcomeView()
                    TopGainersView()
                    TopLoserView()
                    RecentTransactionsView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
