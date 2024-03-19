//
//  RootView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var homeViewModel = HomeViewViewModel()
    @StateObject private var launchViewModel = LaunchViewViewModel()
    
    @State private var selectedTab : Int = 1
    @State private var isLaunching : Bool = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            if isLaunching {
                LaunchView(dataLoadingFinished: $isLaunching)
                    .transition(.opacity)
            }else {
                VStack {
                    TabView(selection: $selectedTab)  {
                        HomeView().tag(1)
                        MarketView().tag(2)
                        PortfolioView().tag(3)
                        SettingsView().tag(4)
                        
                    }
                    CustomTabBar(selectedTab: $selectedTab)
                }.ignoresSafeArea(.keyboard)
            }
        }.environmentObject(homeViewModel)
            .environmentObject(launchViewModel)
        
    }
}

#Preview {
    RootView()
}
