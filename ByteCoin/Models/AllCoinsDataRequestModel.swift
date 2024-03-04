//
//  AllCoinsDataRequestModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 21.02.2024.
//

import Foundation

struct AllCoinsDataRequestModel : Encodable{
    
    let vsCurrency : String
    let id : String?
    let category : String?
    let order : String
    let totalPageNumber : Int
    let page : Int
    let sparkLine : String
    let priceChangePercentage : String
    let localization : String
    let precision : String?
    
    enum CodingKeys : String, CodingKey {
        case vsCurrency = "vs_currency"
        case id = "ids"
        case category
        case order
        case totalPageNumber = "per_page"
        case page
        case sparkLine = "sparkline"
        case priceChangePercentage = "price_change_percentage"
        case localization = "locale"
        case precision
    }
}
