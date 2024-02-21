//
//  APIRequestService.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import Foundation

enum APIRequestService {
    case allCoinCurrencies
    
    private var baseURL: URL {
        return URL(string: Constants.rootApiURL)!
    }
    
    private var path : String {
        switch self {
        case .allCoinCurrencies:
            return "coins/markets"
        }
    }
    
    var url : String {
        let url = baseURL.appendingPathComponent(path)
        return url.absoluteString
    }
    
    var parameters : Encodable {
        switch self {
        case .allCoinCurrencies:
            return AllCoinsDataRequestModel(
                vsCurrency: "usd",
                id: nil,
                category: nil,
                order: "market_cap_desc",
                totalPageNumber: 100,
                page: 1,
                sparkLine: true,
                priceChangePercentage: "24h",
                localization: "en",
                precision: nil
            )
        }
    }
    
}
