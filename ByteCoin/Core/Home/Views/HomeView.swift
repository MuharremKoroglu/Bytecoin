//
//  ContentView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
        
    var body: some View {
        NavigationStack {
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing: 10) {
                    WelcomeView()
                    TopGainerAndLosersSharedView(title: "Top Gainers", coinList: homeViewModel.topGainerCoins)
                    TopGainerAndLosersSharedView(title: "Top Losers", coinList: homeViewModel.topLoserCoins)
                    WatchListView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
