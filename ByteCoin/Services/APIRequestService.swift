//
//  APIRequestService.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import Foundation
import Alamofire

enum APIRequestService {
    case allCoinCurrencies
    case allUsers
    
    private var baseURL: URL {
        switch self {
        case .allCoinCurrencies:
            return URL(string: Constants.coinRootApiURL)!
        case .allUsers:
            return URL(string: Constants.userRootApiURL)!
            
        }
        
    }
    
    private var path : String {
        switch self {
        case .allCoinCurrencies:
            return "coins/markets"
        case .allUsers:
            return ""
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .allCoinCurrencies:
            return HTTPHeaders(["x-cg-demo-api-key" : Constants.coinApiKey])
        case .allUsers:
            return HTTPHeaders()
        }
    }
    
    var url : String {
        switch self {
        case .allCoinCurrencies:
            let url = baseURL.appendingPathComponent(path)
            return url.absoluteString
        case .allUsers:
            let url = baseURL.appendingPathComponent(path)
            return url.absoluteString
        }
        
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
                sparkLine: "true",
                priceChangePercentage: "24h",
                localization: "en",
                precision: nil
            )
        case .allUsers:
            return AllUserDataRequestModel(
                results: 4,
                include: "name,picture",
                nationality: "us",
                noinfo: "noinfo"
            )
        }
    }
    
    var requestMethod : HTTPMethod {
        switch self {
        case .allCoinCurrencies:
            return .get
        case .allUsers:
            return .get
        }
    }
    
}
