//
//  FirebaseWatchListDataModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 7.03.2024.
//

import Foundation

struct FirebaseWatchListDataModel : Codable {
    
    let coinId : String
    
    enum CodingKeys : String, CodingKey {
        case coinId = "coin_id"
    }
    
    
}
