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
    @Published var watchListCoins : [AllCoinsDataResponseModel] = []
    @Published var topGainerCoins : [AllCoinsDataResponseModel] = []
    @Published var topLoserCoins : [AllCoinsDataResponseModel] = []

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
    
    private var page = 1
    private let databaseManager = DatabaseManager()
    private let networkService = NetworkService()
    
    func getCoinsForTopGainerAndLoserList () async {
        
        let response =  await networkService.networkService(
            request: APIRequestService.allCoinCurrencies,
            data: [AllCoinsDataResponseModel].self
        )
        
        switch response {
        case .success(let allCryptos):
            setUpTopGainersAndLosersCoinList(coins: allCryptos)
        case .failure(let error):
            print("COİN VERİLERİ GETİRİLEMEDİ : \(error)")
        }
        
    }
    
    func loadMoreCoinDataIfNeeded (coin : AllCoinsDataResponseModel) async {
        
        let currentIndex =  marketCoins.firstIndex(where: {$0.id == coin.id})
        
        let thresholdIndex = (marketCoins.endIndex) - 1
        
        if currentIndex == thresholdIndex {
            startProgressIndicator = true
            page += 1
            await getCoinsWithPagination()
            startProgressIndicator = false
        }
        
    }
    
    func getCoinsWithPagination () async {
        
        let response = await networkService.networkService(
            request: .coinsForPagination(page: page),
            data: [AllCoinsDataResponseModel].self
        )
        
        switch response {
        case .success(let coins):
            marketCoins.append(contentsOf: coins)
        case .failure(let error):
            print("PAGİNATİON İLE COİN VERİLERİ GETİRİLEMEDİ : \(error)")
        }
        
    }

    
    func getPortfolioCoins (userId : String) async {
        
        do {
            startProgressIndicator = true
            let fetchedPortfolioCoinsFromFirebase = try await databaseManager.getMultipleData(
                userId: userId,
                query: .portfolio,
                objectType: FirebaseUserProfileDataModel.self
            )
                        
            let coinIds = fetchedPortfolioCoinsFromFirebase.map({$0.coinId})
            
            let fetchedCoinsFromApi = await getCoinsWithIds(ids: coinIds)
            
            let updatedList = fetchedPortfolioCoinsFromFirebase.compactMap { coinFromFirebase in
                let coin = fetchedCoinsFromApi.first(where: {$0.id == coinFromFirebase.coinId})
                return coin?.updateHoldingsAndWatchList(
                    amount: coinFromFirebase.coinAmount ?? 0,
                    isInWatchList: coinFromFirebase.isInWatchList ?? false
                )
            }
            
            let sortedPortfolioList = updatedList.sorted(by: {$0.totalPrice > $1.totalPrice})
            portfolioCoins = sortedPortfolioList
            calculateWalletValues()
            reloadPortfolio = false
            startProgressIndicator = false
            
        }catch {
            print("PORTFOLYO ALINAMADI :\(error)")
        }
        
    }
    
    func getWatchListCoins (userId : String) async {
        
        do {
            startProgressIndicator = true
            let fetchedWatchListCoinsFromFirebase = try await databaseManager.getMultipleData(
                userId: userId,
                query: .watchList,
                objectType: FirebaseUserProfileDataModel.self
            )
            
            let coinIds = fetchedWatchListCoinsFromFirebase.map({$0.coinId})
            
            let fetchedCoinsFromApi = await getCoinsWithIds(ids: coinIds)
            
            let updatedList = fetchedWatchListCoinsFromFirebase.compactMap { coinFromFirebase in
                let coin = fetchedCoinsFromApi.first(where: {$0.id == coinFromFirebase.coinId})
                return coin?.updateHoldingsAndWatchList(
                    amount:coinFromFirebase.coinAmount ?? 0,
                    isInWatchList: true
                )
            }
            
            let sortedWatchList = updatedList.sorted(by: {$0.marketCapRank ?? 0 < $1.marketCapRank ?? 1})
            watchListCoins = sortedWatchList
            reloadWatchList = false
            startProgressIndicator = false
            
        }catch {
            print("WATCH LİST ALINAMADI :\(error)")
        }
        
    }
    
    func getAndUpdateCoin (userId : String, coin : AllCoinsDataResponseModel) async {
        
        startProgressIndicator = true
        do {
            let firebaseCoin = try await databaseManager.getSingleData(
                userId: userId,
                collectionId: coin.id ?? "",
                objectType: FirebaseUserProfileDataModel.self
            )
            
            let updatedCoin = coin.updateHoldingsAndWatchList(
                amount: firebaseCoin.coinAmount ?? 0,
                isInWatchList: firebaseCoin.isInWatchList ?? false
            )
      
            self.updatedCoin = updatedCoin
            startProgressIndicator = false

        }catch {
            
            let updatedCoin = coin.updateHoldingsAndWatchList(
                amount: 0,
                isInWatchList: false
            )
                        
            self.updatedCoin = updatedCoin
            startProgressIndicator = false
            
            print("TEKİL PORTFOLYO ALINAMADI :\(error)")
        }
        
    }
    
    func setNewWatchListCoin (userId : String, coin: AllCoinsDataResponseModel) {
        
        Task {
            startProgressIndicator = true
            if watchListCoins.contains(where: { $0.id == coin.id}) || portfolioCoins.contains(where: { $0.id == coin.id}) {
                if let isInWatchList = coin.isInWatchList {
                    if coin.currentCoinAmount == 0 && isInWatchList {
                        do {
                            try await databaseManager.deleteData(
                                userId: userId,
                                collectionId: coin.id ?? ""
                            )
                            reloadWatchList = true
                            startProgressIndicator = false
                        }catch {
                            print("setNewWatchListCoin FONKSİYONUNDA COİN SİLİNEMEDİ : \(error)")
                        }
                    }else {
                        do {
                            try await databaseManager.updateData(
                                userId: userId,
                                collectionId: coin.id ?? "",
                                field: FirebaseUserProfileDataModel.CodingKeys.isInWatchList.rawValue,
                                newValue: !isInWatchList
                            )
                            reloadWatchList = true
                            startProgressIndicator = false
                        }catch {
                            print("setNewWatchListCoin FONKSİYONUNDA WATCH LİST COİN UPDATE EDİLEMEDİ")
                        }
                    }
                }
            }else {
                do {
                    let data = FirebaseUserProfileDataModel(
                        coinId: coin.id ?? "",
                        coinAmount: coin.currentCoinAmount,
                        isInWatchList: true
                    )
                    try await databaseManager.createData(userId: userId, collectionId: coin.id ?? "", data: data)
                    reloadWatchList = true
                    startProgressIndicator = false
                }catch {
                    print("setNewWatchListCoin FONKSİYONUNDA WATCH LİST COİN SET EDİLEMEDİ")
                }
            }
        }
        
    }
    
    func buyCoin (userId : String, coin : AllCoinsDataResponseModel, newCoinAmount : Double) {
        
        Task {
            startProgressIndicator = true
            if portfolioCoins.contains(where: {$0.id == coin.id}) || watchListCoins.contains(where: { $0.id == coin.id}) {
                
                if var currentAmount = coin.currentCoinAmount {
                    currentAmount += newCoinAmount
                    do {
                        try await databaseManager.updateData(
                            userId: userId,
                            collectionId: coin.id ?? "",
                            field: FirebaseUserProfileDataModel.CodingKeys.coinAmount.rawValue,
                            newValue: currentAmount
                        )
                        reloadPortfolio = true
                        isCompletedSuccessfully = true
                        startProgressIndicator = false
                    }catch {
                        print("buyCoin FONKSİYONUNDA COİN UPDATE EDİLEMEDİ : \(error)")
                    }
                }
            }else {
                do {
                    let data = FirebaseUserProfileDataModel(
                        coinId: coin.id ?? "",
                        coinAmount: newCoinAmount,
                        isInWatchList: false
                    )
                    try await databaseManager.createData(
                        userId: userId,
                        collectionId: coin.id ?? "",
                        data: data
                    )
                    reloadPortfolio = true
                    isCompletedSuccessfully = true
                    startProgressIndicator = false
                }catch {
                    print("buyCoin FONKSİYONUNDA COİN SET EDİLEMEDİ : \(error)")
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
                    if !(coin.isInWatchList ?? true ) {
                        do {
                            try await databaseManager.deleteData(userId: userId, collectionId: coin.id ?? "")
                            reloadPortfolio = true
                            startProgressIndicator = false
                            isCompletedSuccessfully = true
                            isCoinDeletedFromPortfolio = true
                        }catch {
                            print("sellCoin FONKSİYONUNDA COİN SİLİNEMEDİ : \(error)")
                        }
                    }else {
                        do {
                            try await databaseManager.updateData(
                                userId: userId,
                                collectionId: coin.id ?? "",
                                field: FirebaseUserProfileDataModel.CodingKeys.coinAmount.rawValue,
                                newValue: 0
                            )
                            reloadPortfolio = true
                            startProgressIndicator = false
                            isCompletedSuccessfully = true
                            isCoinDeletedFromPortfolio = true
                        }catch {
                            print("sellCoin FONKSİYONUNDA COİN 0 OLARAK UPDATE EDİLEMEDİ : \(error)")
                        }
                    }
                }else {
                    do {
                        try await databaseManager.updateData(
                            userId: userId,
                            collectionId: coin.id ?? "",
                            field: FirebaseUserProfileDataModel.CodingKeys.coinAmount.rawValue,
                            newValue: currentAmount
                        )
                        reloadPortfolio = true
                        startProgressIndicator = false
                        isCompletedSuccessfully = true
                    }catch {
                        print("sellCoin FONKSİYONUNDA COİN UPDATE EDİLEMEDİ : \(error)")
                    }
                }
            }
        }
    }
    
}

extension HomeViewViewModel {
    
    private func getCoinsWithIds (ids : [String]) async -> [AllCoinsDataResponseModel]{
        
        let reponse = await networkService.networkService(
            request: .coinsForPortfolioAndWatchList(ids: ids),
            data: [AllCoinsDataResponseModel].self
        )
        
        switch reponse {
        case .success(let coins):
            return coins
        case .failure(let error):
            print("ID'lere Göre COIN GETİRİLEMEDİ : \(error)")
        }
        
        return []
    }
    
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
    
    private func setUpTopGainersAndLosersCoinList (coins : [AllCoinsDataResponseModel]) {
        
        let highestChangeSortedList = coins.sorted(by: {$0.priceChangePercentage24H ?? 1 > $1.priceChangePercentage24H ?? 0})
        let lowestChangeSortedList = coins.sorted(by: {$0.priceChangePercentage24H ?? 1 < $1.priceChangePercentage24H ?? 0})
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

