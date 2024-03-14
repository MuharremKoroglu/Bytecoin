//
//  LaunchView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 5.03.2024.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject private var launchViewModel : LaunchViewViewModel
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    
    @Binding var dataLoadingFinished : Bool
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            VStack {
                LottieView(animationName: "crypto")
                    .frame(width: size.width , height: size.height * 0.3)
                Text("Welcome to ByteCoin")
                    .font(.title.italic())
                    .fontWeight(.bold)
                Text("Loading Your Profile")
                    .font(.headline)
                    .padding(.top,5)

            }.frame(width: size.width, height: size.height)
                .task{
                    await homeViewModel.getAllCoins()
                    await launchViewModel.signIn()
                    await homeViewModel.getPortfolioCoins(userId: launchViewModel.userId)
                    await homeViewModel.getWatchListCoins(userId: launchViewModel.userId)
                    withAnimation(.spring) {
                        dataLoadingFinished = false
                    }
                }
        }
    }
}
