//
//  FirebaseDataModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 1.03.2024.
//

import Foundation

struct FirebasePortfolioDataModel : Codable {
    
    let coinId : String
    let coinAmount : Double?
    
    enum CodingKeys : String, CodingKey {
        case coinId = "coin_id"
        case coinAmount = "coin_amount"
    }
    
}
