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
    @Published var allUsers : [UserResult] = []
    
    @Published var isCoinInPortfolio : Bool = false
    @Published var coinAmount : Double = 0
    
    @Published var marketCoinSearchedText : String = ""
    @Published var portfolioCoinSearchedText : String = ""
    
    @Published var isCompletedSuccessfully : Bool = false
    
    var filteredMarketCoins: [AllCoinsDataResponseModel] {
        return self.filterCoins(searchedText: marketCoinSearchedText, coins: marketCoins)
    }
    
    var filteredPortfolioCoins: [AllCoinsDataResponseModel] {
        return self.filterCoins(searchedText: portfolioCoinSearchedText, coins: portfolioCoins)
    }
    
    private var userUid : String = ""
    private let databaseManager = DatabaseManager()
    private let authenticationManager = AuthenticationManager()
    private var networkService = NetworkService()
    
    init() {
        signIn()
        getAllCoins()
        getAllUser()
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
    
    func getPortfolioCoins () {
        
        Task {
            do {
                let fetchedCoinsFromFirebase = try await databaseManager.getMultipleDocumentData(userId: userUid)
                let updatedList = fetchedCoinsFromFirebase.compactMap { coinFromFirebase in
                    let coin = marketCoins.first(where: {$0.id == coinFromFirebase.coinId})
                    return coin?.updateHolgins(amount: coinFromFirebase.coinAmount ?? 0)
                }
                portfolioCoins = updatedList
            }catch {
                print("PORTFOLYO ALINAMADI :\(error)")
            }
        }
        
    }
    
    func getSingleCoinFromFirebase (coin : AllCoinsDataResponseModel) {
        
        Task {
            do {
                let firebaseCoin = try await databaseManager.getSingleDocumentData(userId: userUid, coinId: coin.id ?? "")
                isCoinInPortfolio = true
                coinAmount = firebaseCoin.coinAmount ?? 0
            }catch {
                isCoinInPortfolio = false
                coinAmount = 0
                print("TEKİL PORTFOLYO ALINAMADI :\(error)")
            }
        }
        
    }
    
    func buyCoin (coin : AllCoinsDataResponseModel, newCoinAmount : Double) {
        
        Task {
            if coinAmount != 0 {
                var coinQuantity = coinAmount
                coinQuantity += newCoinAmount
                do {
                    try await databaseManager.updateData(userId: userUid, coinId: coin.id ?? "", newValue: coinQuantity)
                    isCompletedSuccessfully = true
                }catch {
                    print("HomeViewViewModel' de BUY COIN FONKİSYONUNDA COIN UPDATE EDİLMEDİ : \(error)")
                }
            }else {
                let data = FirebaseDataModel(coinId: coin.id ?? "", coinAmount: newCoinAmount)
                do {
                    try await databaseManager.createData(userId: userUid, data: data)
                    isCompletedSuccessfully = true
                }catch {
                    print("HomeViewViewModel' de BUY COIN FONKİSYONUNDA COIN CREATE EDİLMEDİ : \(error)")
                }
            }
        }
    }
    
    func sellCoin (coin : AllCoinsDataResponseModel, newCoinAmount : Double) {
        
        Task {
            var coinQuantity = coinAmount
            coinQuantity -= newCoinAmount
            if coinQuantity <= 0 {
                do {
                    try await databaseManager.deleteData(userId: userUid, coinId: coin.id ?? "")
                    isCompletedSuccessfully = true
                }catch {
                    print("CoinExchangeViewViewModel' de SELL COIN FONKİSYONUNDA COIN DELETE EDİLMEDİ : \(error)")
                }
            }else {
                do {
                    try await databaseManager.updateData(userId: userUid, coinId: coin.id ?? "", newValue: coinQuantity )
                    isCompletedSuccessfully = true
                }catch {
                    print("CoinExchangeViewViewModel' de SELL COIN FONKİSYONUNDA COIN UPDATE EDİLMEDİ : \(error)")
                }
            }
        }
        
    }
    
    private func getAllUser () {
        
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
    
    private func signIn () {
        Task {
            do {
                if let user = try await authenticationManager.signInAnonymously() {
                    userUid = user.uid
                }
            }catch {
                print("KULLANICI GİRİŞİNDE HATA : \(error)")
            }
            
        }
    }

}

extension HomeViewViewModel {
    
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

