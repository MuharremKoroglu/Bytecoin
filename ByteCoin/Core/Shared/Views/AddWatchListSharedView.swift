//
//  AddWatchListSharedView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 8.03.2024.
//

import SwiftUI

struct AddWatchListSharedView: View {
    
    @EnvironmentObject private var launchViewModel : LaunchViewViewModel
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        VStack {
            
            AddWatchListButtonItem(isInWatchList: homeViewModel.updatedCoin?.isInWatchList ?? false) {
                homeViewModel.setNewWatchListCoin(userId: launchViewModel.userId, coin: homeViewModel.updatedCoin ?? coin)
            }
            
        }.task {
            await homeViewModel.getAndUpdateCoin(userId: launchViewModel.userId, coin: coin)
        }
        .onReceive(homeViewModel.$reloadWatchList) { isUpdated in
            if isUpdated {
                Task {
                    await homeViewModel.getAndUpdateCoin(userId:launchViewModel.userId, coin: coin)
                }
            }
        }
    }
}

