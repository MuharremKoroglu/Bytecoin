//
//  CoinDetailDataRequestModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import Foundation

/*
 https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false
 */

struct CoinDetailDataRequestModel : Encodable {
    
    let localization : String
    let tickers : Bool
    let marketData : Bool
    let communityData : Bool
    let developerData : Bool
    let sparkLine : Bool
    
    enum CodingKeys : String, CodingKey {
        
        case localization
        case tickers
        case marketData = "market_data"
        case communityData = "community_data"
        case developerData = "developer_data"
        case sparkLine = "sparkline"
        
    }

}
