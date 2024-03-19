//
//  FirebaseDataModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 1.03.2024.
//

import Foundation

struct FirebaseUserProfileDataModel : Codable {
    
    let coinId : String
    let coinAmount : Double?
    let isInWatchList : Bool?
    
    enum CodingKeys : String, CodingKey {
        case coinId = "coin_id"
        case coinAmount = "coin_amount"
        case isInWatchList = "is_in_watch_list"
    }
    
}
