//
//  WelcomeView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    @EnvironmentObject private var launchViewModel : LaunchViewViewModel
        
    var body: some View {
        VStack(spacing : 10) {
            
            UserWelcome()
            AccountBalance(accountBalance: homeViewModel.balance, accountProfit: homeViewModel.profit)
            
        }.padding(.horizontal, 15)
            .onReceive(homeViewModel.$reloadPortfolio) { isUpdated in
                if isUpdated {
                    Task {
                        await homeViewModel.getPortfolioCoins(userId: launchViewModel.userId)
                    }
                }
            }
    }
}

