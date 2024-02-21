//
//  CryptoModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import Foundation

//MARK: - CryptoModel
struct CryptoModel: Identifiable, Codable {
    
    let id : String?
    let symbol : String?
    let name : String?
    let image : String?
    let currentPrice : Double?
    let marketCap : Double?
    let marketCapRank : Double?
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
    }
}

// MARK: - Roi
struct Roi: Codable {
    let times: Double?
    let currency: String?
    let percentage: Double?
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}
