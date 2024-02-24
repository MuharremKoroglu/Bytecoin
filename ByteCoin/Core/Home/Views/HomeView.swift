//
//  ContentView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing: 10) {
                    WelcomeView(viewModel: viewModel)
                    TopGainersView(viewModel: viewModel)
                    TopLoserView(viewModel: viewModel)
                    RecentTransactionsView(viewModel: viewModel)
                }.onAppear{
                    viewModel.getAllUser()
                    viewModel.getAllCurrencies()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
