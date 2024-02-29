//
//  DatabaseUserModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 29.02.2024.
//

import Foundation

struct DatabasePortfolioModel : Codable {
    
    let userId : String
    let coinId : String
    let coinAmount : Double
    
    enum CodingKeys : String,CodingKey {
        case userId = "user_id"
        case coinId = "coin_id"
        case coinAmount = "coin_amount"
    }

}
