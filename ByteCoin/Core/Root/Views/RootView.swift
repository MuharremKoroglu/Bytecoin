//
//  RootView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var selectedTab : Int = 1

    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack {
            TabView(selection: $selectedTab)  {
                HomeView().tag(1)
                MarketView().tag(2)
                Text("Tab Content 3").tag(3)
                Text("Tab Content 4").tag(4)
                
            }
            CustomTabBar(selectedTab: $selectedTab)
        }
        
        
    }
}

#Preview {
    RootView()
}
