//
//  HomeScreenViewModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import Foundation

@MainActor
class HomeViewViewModel : ObservableObject {
    
    @Published var marketCoins : [AllCoinsDataResponseModel] = []
    @Published var portfolioCoins : [AllCoinsDataResponseModel] = []
    @Published var topGainerCoins : [AllCoinsDataResponseModel] = []
    @Published var topLoserCoins : [AllCoinsDataResponseModel] = []
    @Published var watchListCoins : [AllCoinsDataResponseModel] = []
    @Published var allUsers : [UserResult] = []
    
    @Published var marketCoinSearchedText : String = ""
    @Published var portfolioCoinSearchedText : String = ""
    
    @Published var isCompletedSuccessfully : Bool = false
    @Published var isCoinDeletedFromPortfolio : Bool = false
    @Published var reloadPortfolio : Bool = false
    
    @Published var isInWatchList : Bool = false
    @Published var reloadWatchList : Bool = false
    
    @Published var balance : Double = 0
    @Published var profit : Double = 0
    
    @Published var updatedCoin : AllCoinsDataResponseModel?
    
    var filteredMarketCoins: [AllCoinsDataResponseModel] {
        return self.filterCoins(searchedText: marketCoinSearchedText, coins: marketCoins)
    }
    
    var filteredPortfolioCoins: [AllCoinsDataResponseModel] {
        return self.filterCoins(searchedText: portfolioCoinSearchedText, coins: portfolioCoins)
    }
    
    private let databaseManager = DatabaseManager()
    private let networkService = NetworkService()
    
    init() {
        getAllCoins()
    }
    
    func getAllCoins () {
                
        Task {
            let response = try await networkService.networkService(
                request: APIRequestService.allCoinCurrencies,
                data: [AllCoinsDataResponseModel].self
            )
            
            switch response {
            case .success(let allCryptos):
                marketCoins = allCryptos
                setUpTopGainersAndLosersCoinList()
            case .failure(let error):
                print("COİN VERİLERİ GETİRİLEMEDİ : \(error)")
            }
        }
        
    }
    
    func getPortfolioCoins (userId : String) {
        
        Task {
            do {
                let fetchedCoinsFromFirebase = try await databaseManager.getMultipleData(userId: userId, collectionName: .portfolio, objectType: FirebasePortfolioDataModel.self)
                let updatedList = fetchedCoinsFromFirebase.compactMap { coinFromFirebase in
                    let coin = marketCoins.first(where: {$0.id == coinFromFirebase.coinId})
                    return coin?.updateHoldingsAndWatchList(amount:coinFromFirebase.coinAmount ?? 0)
                }
                portfolioCoins = updatedList
                calculateWalletValues()
            }catch {
                print("PORTFOLYO ALINAMADI :\(error)")
            }
            
        }
    }
    
    func getWatchListCoins (userId : String) {
        Task {
            do {
                let fetchedWatchListCoinsFromFirebase = try await databaseManager.getMultipleData(userId: userId, collectionName: .watchlist, objectType: FirebaseWatchListDataModel.self)
                let updatedWatchList = fetchedWatchListCoinsFromFirebase.compactMap { coinFromFirebase in
                    let coin = marketCoins.first(where: {$0.id == coinFromFirebase.coinId})
                    return coin
                }
                let sortedWatchList = updatedWatchList.sorted(by: {$0.marketCapRank ?? 1 < $1.marketCapRank ?? 0})
                watchListCoins = sortedWatchList
            }catch {
                print("WATCH LİST ALINAMADI :\(error)")
            }
        }
    }
    
    func getSinglePortfolioCoin (userId : String, coin : AllCoinsDataResponseModel){
        
        Task {
            do {
                let firebaseCoin = try await databaseManager.getSingleData(userId: userId, collectionName: .portfolio, collectionId: coin.id ?? "", objectType: FirebasePortfolioDataModel.self)
                updatedCoin = coin.updateHoldingsAndWatchList(amount: firebaseCoin.coinAmount ?? 0)
            }catch {
                updatedCoin = coin.updateHoldingsAndWatchList(amount: 0)
                print("TEKİL PORTFOLYO ALINAMADI :\(error)")
            }
        }
        
    }
    
    func getSingleWatchListCoin (userId : String, coin : AllCoinsDataResponseModel) {
        Task {
            do {
                let watchListCoinFromFirebase = try await databaseManager.getSingleData(userId: userId, collectionName: .watchlist, collectionId: coin.id ?? "", objectType: FirebaseWatchListDataModel.self)
                if coin.id == watchListCoinFromFirebase.coinId {
                    isInWatchList = true
                    reloadWatchList = true
                }
            }catch {
                isInWatchList = false
                reloadWatchList = true
                print("TEKİL WATCH LİST COİN ALINAMADI :\(error)")
            }
        }
    }
    
    func setNewWatchListCoin (userId : String, coin: AllCoinsDataResponseModel) {
        
        Task {
            do {
                let data = FirebaseWatchListDataModel(coinId: coin.id ?? "")
                try await databaseManager.createData(userId: userId, collectionName: .watchlist, collectionId: coin.id ?? "", data: data)
                reloadWatchList = true
            }catch {
                print("YENİ WATCH LİST COİN SET EDİLEMEDİ : \(error)")
            }
        }
        
    }
    
    func deleteCoinFromWatchList (userId : String, coin: AllCoinsDataResponseModel) {
        
        Task {
            do {
                try await databaseManager.deleteData(userId: userId, collectionName: .watchlist, coinId: coin.id ?? "")
                isInWatchList = false
                reloadWatchList = true
            }catch {
                print("COİN WATCH LİST'ten SİLİNEMEDİ : \(error)")
            }
        }
    }
    
    func buyCoin (userId : String, coin : AllCoinsDataResponseModel, newCoinAmount : Double) {

        Task {
            if var currentAmount = coin.currentCoinAmount {
                if currentAmount != 0 {
                    currentAmount += newCoinAmount
                    do {
                        try await databaseManager.updateData(userId: userId, collectionName: .portfolio, collectionId: coin.id ?? "", newValue: currentAmount)
                        isCompletedSuccessfully = true
                        reloadPortfolio = true
                    }catch {
                        print("HomeViewViewModel' de BUY COIN FONKİSYONUNDA COIN UPDATE EDİLMEDİ : \(error)")
                    }
                }else {
                    let data = FirebasePortfolioDataModel(coinId: coin.id ?? "", coinAmount: newCoinAmount)
                    isCompletedSuccessfully = true
                    reloadPortfolio = true
                    do {
                        try await databaseManager.createData(userId: userId, collectionName: .portfolio, collectionId: coin.id ?? "", data: data)
                    }catch {
                        print("HomeViewViewModel' de BUY COIN FONKİSYONUNDA COIN CREATE EDİLMEDİ : \(error)")
                    }
                }
            }
        }
        
    }
    
    func sellCoin (userId : String, coin : AllCoinsDataResponseModel, newCoinAmount : Double) {

        Task {
            if var currentAmount = coin.currentCoinAmount {
                currentAmount -= newCoinAmount
                if currentAmount <= 0 {
                    do {
                        try await databaseManager.deleteData(userId: userId, collectionName: .portfolio, coinId: coin.id ?? "")
                        isCompletedSuccessfully = true
                        reloadPortfolio = true
                        isCoinDeletedFromPortfolio = true
                    }catch {
                        print("SELL COIN FONKİSYONUNDA COIN DELETE EDİLMEDİ : \(error)")
                    }
                }else {
                    do {
                        try await databaseManager.updateData(userId: userId, collectionName: .portfolio, collectionId: coin.id ?? "", newValue: currentAmount)
                        isCompletedSuccessfully = true
                        reloadPortfolio = true
                    }catch {
                        print("SELL COIN FONKİSYONUNDA COIN UPDATE EDİLMEDİ : \(error)")
                    }
                }
            }
        }
        
    }
    
    func getAllUser () {
        
        Task {
            let response = try await networkService.networkService(request: APIRequestService.allUsers, data: AllUserDataResponseModel.self)
            
            switch response {
            case .success(let allUsers):
                self.allUsers = allUsers.results ?? []
            case .failure(let failure):
                print("KULLANICI VERİLERİ GETİRİLEMEDİ : \(failure)")
            }

        }
    }

}

extension HomeViewViewModel {
    
    private func calculateWalletValues () {
        let portfolioValue = portfolioCoins.map({$0.totalPrice}).reduce(0, +)
        let previousValue = portfolioCoins.map { coin in
            let currentValue = coin.totalPrice
            let changePercentage = (coin.priceChangePercentage24H ?? 0) / 100
            let previousValue = currentValue / (1 + changePercentage)
            return previousValue
        }
        let totalPreviousValue = previousValue.reduce(0, +)
        let totalProfit = ((portfolioValue - totalPreviousValue) / totalPreviousValue) * 100
        
        self.balance = portfolioValue
        self.profit = totalProfit.isNaN ? 0 : totalProfit

    }
    
    private func setUpTopGainersAndLosersCoinList () {
        
        let highestChangeSortedList = marketCoins.sorted(by: {$0.priceChangePercentage24H ?? 1 > $1.priceChangePercentage24H ?? 0})
        let lowestChangeSortedList = marketCoins.sorted(by: {$0.priceChangePercentage24H ?? 1 < $1.priceChangePercentage24H ?? 0})
        let topGainers = Array(highestChangeSortedList.prefix(5))
        let topLosers = Array(lowestChangeSortedList.prefix(5))
        self.topGainerCoins = topGainers
        self.topLoserCoins = topLosers
        
    }
    
    
    private func filterCoins (searchedText : String, coins : [AllCoinsDataResponseModel]) -> [AllCoinsDataResponseModel] {
        if searchedText.isEmpty {
            return coins
        } else {
            return coins.filter { $0.name!.lowercased().contains(searchedText.lowercased()) || $0.symbol!.lowercased().contains(searchedText.lowercased()) }
        }
    }
    
}

