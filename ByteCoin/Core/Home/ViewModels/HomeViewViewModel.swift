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
    
    @Published var marketCoinSearchedText : String = ""
    @Published var portfolioCoinSearchedText : String = ""
    
    @Published var isCompletedSuccessfully : Bool = false
    @Published var isCoinDeletedFromPortfolio : Bool = false
    @Published var reloadPortfolio : Bool = false
    
    @Published var reloadWatchList : Bool = false
    
    @Published var startProgressIndicator : Bool = false
    
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
    
    func getAllCoins () async {
        
        let response =  await networkService.networkService(
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
    
    func getPortfolioCoins (userId : String) async {
        
        do {
            let fetchedCoinsFromFirebase = try await databaseManager.getMultipleData(userId: userId, collectionName: .portfolio, objectType: FirebasePortfolioDataModel.self)
            let updatedList = fetchedCoinsFromFirebase.compactMap { coinFromFirebase in
                let coin = marketCoins.first(where: {$0.id == coinFromFirebase.coinId})
                let watchCoin = watchListCoins.first(where: {$0.id == coinFromFirebase.coinId})
                let isInWatchList = coin?.id == watchCoin?.id
                return coin?.updateHoldingsAndWatchList(amount:coinFromFirebase.coinAmount ?? 0, isInWatchList: isInWatchList)
            }
            let sortedPortfolioList = updatedList.sorted(by: {$0.totalPrice > $1.totalPrice})
            portfolioCoins = sortedPortfolioList
            calculateWalletValues()
            reloadPortfolio = false
        }catch {
            print("PORTFOLYO ALINAMADI :\(error)")
        }
        
    }
    
    func getWatchListCoins (userId : String) async {
        
        do {
            let fetchedWatchListCoinsFromFirebase = try await databaseManager.getMultipleData(userId: userId, collectionName: .watchlist, objectType: FirebaseWatchListDataModel.self)
            let updatedWatchList = fetchedWatchListCoinsFromFirebase.compactMap { coinFromFirebase in
                let coin = marketCoins.first(where: {$0.id == coinFromFirebase.coinId})
                let portfolioCoin = portfolioCoins.first(where: {$0.id == coinFromFirebase.coinId})
                return coin?.updateHoldingsAndWatchList(amount: portfolioCoin?.currentCoinAmount ?? 0, isInWatchList: true)
            }
            let sortedWatchList = updatedWatchList.sorted(by: {$0.marketCapRank ?? 0 < $1.marketCapRank ?? 1})
            watchListCoins = sortedWatchList
            reloadWatchList = false
        }catch {
            print("WATCH LİST ALINAMADI :\(error)")
        }
        
    }
    
    func getSinglePortfolioCoin (userId : String, coin : AllCoinsDataResponseModel) async {
        
        do {
            let firebaseCoin = try await databaseManager.getSingleData(userId: userId, collectionName: .portfolio, collectionId: coin.id ?? "", objectType: FirebasePortfolioDataModel.self)
            let watchCoin = watchListCoins.first(where: {$0.id == firebaseCoin.coinId})
            let isInWatchList = watchCoin?.id == firebaseCoin.coinId
            updatedCoin = coin.updateHoldingsAndWatchList(amount: firebaseCoin.coinAmount ?? 0, isInWatchList: isInWatchList)
            reloadPortfolio = false
        }catch {
            let watchCoin = watchListCoins.first(where: {$0.id == coin.id})
            let isInWatchList = watchCoin?.id == coin.id
            updatedCoin = coin.updateHoldingsAndWatchList(amount: 0, isInWatchList: isInWatchList)
            reloadPortfolio = false
            print("TEKİL PORTFOLYO ALINAMADI :\(error)")
        }
        
    }
    
    func getSingleWatchListCoin (userId : String, coin : AllCoinsDataResponseModel) async {
        
        do {
            let firebaseCoin = try await databaseManager.getSingleData(userId: userId, collectionName: .watchlist, collectionId: coin.id ?? "", objectType: FirebaseWatchListDataModel.self)
            let portfolioCoin = portfolioCoins.first(where: {$0.id == firebaseCoin.coinId})
            updatedCoin = coin.updateHoldingsAndWatchList(amount: portfolioCoin?.currentCoinAmount ?? 0, isInWatchList: true)
            reloadWatchList = false
        }catch {
            let portfolioCoin = portfolioCoins.first(where: {$0.id == coin.id})
            updatedCoin = coin.updateHoldingsAndWatchList(amount: portfolioCoin?.currentCoinAmount ?? 0, isInWatchList: false)
            reloadWatchList = false
            print("TEKİL WATCH LİST COİN ALINAMADI :\(error)")
        }
        
    }
    
    func setNewWatchListCoin (userId : String, coin: AllCoinsDataResponseModel) {
        
        Task {
            if let watchListCoin = coin.isInWatchList {
                
                if !watchListCoin {
                    do {
                        let data = FirebaseWatchListDataModel(coinId: coin.id ?? "")
                        try await databaseManager.createData(userId: userId, collectionName: .watchlist, collectionId: coin.id ?? "", data: data)
                        reloadWatchList = true
                    }catch {
                        print("YENİ WATCH LİST COİN SET EDİLEMEDİ : \(error)")
                    }
                }else {
                    do {
                        try await databaseManager.deleteData(userId: userId, collectionName: .watchlist, coinId: coin.id ?? "")
                        reloadWatchList = true
                    }catch {
                        print("COİN WATCH LİST'ten SİLİNEMEDİ : \(error)")
                    }
                }
            }
        }
        
    }
    
    func buyCoin (userId : String, coin : AllCoinsDataResponseModel, newCoinAmount : Double) {

        Task {
            startProgressIndicator = true
            if var currentAmount = coin.currentCoinAmount {
                if currentAmount != 0 {
                    currentAmount += newCoinAmount
                    do {
                        try await databaseManager.updateData(userId: userId, collectionName: .portfolio, collectionId: coin.id ?? "", newValue: currentAmount)
                        reloadPortfolio = true
                        isCompletedSuccessfully = true
                        startProgressIndicator = false

                    }catch {
                        print("HomeViewViewModel' de BUY COIN FONKİSYONUNDA COIN UPDATE EDİLMEDİ : \(error)")
                    }
                }else {
                    let data = FirebasePortfolioDataModel(coinId: coin.id ?? "", coinAmount: newCoinAmount)
                    reloadPortfolio = true
                    isCompletedSuccessfully = true
                    startProgressIndicator = false

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
            startProgressIndicator = true
            if var currentAmount = coin.currentCoinAmount {
                currentAmount -= newCoinAmount
                if currentAmount <= 0 {
                    do {
                        try await databaseManager.deleteData(userId: userId, collectionName: .portfolio, coinId: coin.id ?? "")
                        isCompletedSuccessfully = true
                        reloadPortfolio = true
                        isCoinDeletedFromPortfolio = true
                        startProgressIndicator = false
                    }catch {
                        print("SELL COIN FONKİSYONUNDA COIN DELETE EDİLMEDİ : \(error)")
                    }
                }else {
                    do {
                        try await databaseManager.updateData(userId: userId, collectionName: .portfolio, collectionId: coin.id ?? "", newValue: currentAmount)
                        reloadPortfolio = true
                        isCompletedSuccessfully = true
                        startProgressIndicator = false
                    }catch {
                        print("SELL COIN FONKİSYONUNDA COIN UPDATE EDİLMEDİ : \(error)")
                    }
                }
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

