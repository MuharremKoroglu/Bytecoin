//
//  CryptoModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import Foundation

struct AllCoinsDataResponseModel: Identifiable, Codable {
    
    let id : String?
    let symbol : String?
    let name : String?
    let image : String?
    let currentPrice : Double?
    let marketCap : Double?
    let marketCapRank : Int?
    let fullyDilutedValuation : Double?
    let totalVolume : Double?
    let high24H : Double?
    let low24H : Double?
    let priceChange24H : Double?
    let priceChangePercentage24H : Double?
    let marketCapChange24H : Double?
    let marketCapChangePercentage24H : Double?
    let circulatingSupply : Double?
    let totalSupply: Double?
    let maxSupply : Double?
    let ath : Double?
    let athChangePercentage : Double?
    let athDate: String?
    let atl : Double?
    let atlChangePercentage : Double?
    let atlDate: String?
    let roi: Roi?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentCoinAmount : Double?
    let isInWatchList : Bool?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentCoinAmount
        case isInWatchList
    }
    
    func updateHoldingsAndWatchList (amount : Double, isInWatchList : Bool) -> AllCoinsDataResponseModel {
        return AllCoinsDataResponseModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, roi: roi, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentCoinAmount: amount, isInWatchList: isInWatchList)
    }
    
    var totalPrice : Double {
        return (currentCoinAmount ?? 0) * (currentPrice ?? 0)
    }
}

struct Roi: Codable {
    let times: Double?
    let currency: String?
    let percentage: Double?
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
