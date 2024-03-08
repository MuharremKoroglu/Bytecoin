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
            
            AddWatchListButtonItem(isInWatchList: homeViewModel.isInWatchList) {
                if homeViewModel.isInWatchList {
                    homeViewModel.deleteCoinFromWatchList(userId: launchViewModel.userId, coin: coin)
                }else {
                    homeViewModel.setNewWatchListCoin(userId: launchViewModel.userId, coin: coin)
                }
            }
            
        }.onAppear {
            homeViewModel.getSingleWatchListCoin(userId: launchViewModel.userId, coin: coin)
        }
        .onReceive(homeViewModel.$reloadWatchList) { isUpdated in
            if isUpdated {
                homeViewModel.getSingleWatchListCoin(userId: launchViewModel.userId, coin: coin)
            }
        }
    }
}

