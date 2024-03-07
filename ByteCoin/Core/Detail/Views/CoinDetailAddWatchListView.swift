//
//  CoinDetailAddWatchListView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 7.03.2024.
//

import SwiftUI

struct CoinDetailAddWatchListView: View {
    
    @EnvironmentObject private var launchViewModel : LaunchViewViewModel
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    
    @State private var isFirstLaunch : Bool = false
    
    let coin : AllCoinsDataResponseModel
    
    var body: some View {
        VStack {
            let _ = print("HOMEVİEW MODEL DEKİ İSINWATCHLİST DEĞERİ = \(homeViewModel.isInWatchList)")
            AddWatchListButtonItem(isInWatchList: homeViewModel.isInWatchList) {
                if homeViewModel.isInWatchList {
                    homeViewModel.deleteCoinFromWatchList(userId: launchViewModel.userId, coin: coin)
                }else {
                    homeViewModel.setNewWatchListCoin(userId: launchViewModel.userId, coin: coin)
                }
            }
            
        }.onAppear {
            if !isFirstLaunch {
                homeViewModel.getSingleWatchListCoin(userId: launchViewModel.userId, coin: coin)
                isFirstLaunch = true
                //print("ON APPEAR ÇALIŞTI")
            }
            
        }
        .onReceive(homeViewModel.$reloadWatchList) { isUpdated in
            if isUpdated {
                homeViewModel.getSingleWatchListCoin(userId: launchViewModel.userId, coin: coin)
                //print("ON RECEİVE ÇALIŞTI")
            }
        }
    }
}

