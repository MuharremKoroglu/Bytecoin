//
//  ExchangeViewViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import Foundation

class CoinExchangeViewViewModel : ObservableObject {

    @Published var isCompletedSuccessfully : Bool = false
    
    private var coinInPortfolio : FirebaseDataModel? = nil
    private let authenticationManager = AuthenticationManager()
    private let databaseManager = DatabaseManager()
    
    
    func getCoinHoldingInfo (coin : AllCoinsDataResponseModel) {
        
        Task {
            do {
                if let user = try authenticationManager.currentUser() {
                    
                    do {
                        let coin = try await databaseManager.getSingleDocumentData(userId: user.uid, coinId: coin.id ?? "")
                        await MainActor.run {
                            coinInPortfolio = coin
                        }
                    }catch {
                        print("CoinExchangeViewViewModel' de BUY COIN FONKİSYONUNDA VERİ Alınamadı : \(error)")
                    }
                }
            }catch {
                print("CoinExchangeViewViewModel' de getCoinHoldingInfo FONKİSYONUNDA KULLANICI ALINAMADI : \(error)")
            }
        }
    }
    
    
    func buyCoin (coin : AllCoinsDataResponseModel, coinAmount : Double) {
        
        Task {
            do {
                if let user = try authenticationManager.currentUser() {
                    if coinInPortfolio != nil {
                        var currentCoinAmount = coinInPortfolio!.coinAmount
                        currentCoinAmount! += coinAmount
                        do {
                            try await databaseManager.updateData(userId: user.uid, coinId: coin.id ?? "", newValue: currentCoinAmount!)
                            await MainActor.run {
                                isCompletedSuccessfully = true
                            }
                        }catch {
                            print("CoinExchangeViewViewModel' de BUY COIN FONKİSYONUNDA COIN UPDATE EDİLMEDİ : \(error)")
                        }
                    }else {
                        let data = FirebaseDataModel(coinId: coin.id ?? "", coinAmount: coinAmount)
                        do {
                            try await databaseManager.createData(userId: user.uid, data: data)
                            await MainActor.run {
                                isCompletedSuccessfully = true
                            }
                        }catch {
                            print("CoinExchangeViewViewModel' de BUY COIN FONKİSYONUNDA COIN CREATE EDİLMEDİ : \(error)")
                        }
                    }
                }
            }catch {
                print("CoinExchangeViewViewModel' de BUY COIN FONKİSYONUNDA KULLANICI ALINAMADI : \(error)")
            }
        }
    }
    
    func sellCoin (coin : AllCoinsDataResponseModel, coinAmount : Double) {
        
        Task {
            do {
                if let user = try authenticationManager.currentUser() {
                    var currentCoinAmount = coinInPortfolio!.coinAmount
                    currentCoinAmount! -= coinAmount
                    if currentCoinAmount! <= 0 {
                        do {
                            try await databaseManager.deleteData(userId: user.uid, coinId: coin.id ?? "")
                            await MainActor.run {
                                isCompletedSuccessfully = true
                            }
                        }catch {
                            print("CoinExchangeViewViewModel' de SELL COIN FONKİSYONUNDA COIN DELETE EDİLMEDİ : \(error)")
                        }
                    }else {
                        do {
                            try await databaseManager.updateData(userId: user.uid, coinId: coin.id ?? "", newValue: currentCoinAmount ?? 0)
                            await MainActor.run {
                                isCompletedSuccessfully = true
                            }
                        }catch {
                            print("CoinExchangeViewViewModel' de SELL COIN FONKİSYONUNDA COIN UPDATE EDİLMEDİ : \(error)")
                        }
                    }
                }
            }catch {
                print("CoinExchangeViewViewModel' de SELL COIN FONKİSYONUNDA KULLANICI ALINAMADI : \(error)")
            }
        }
    }
    
    
}
