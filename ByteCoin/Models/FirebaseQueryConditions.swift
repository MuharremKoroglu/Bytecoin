//
//  QueryConditions.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 16.03.2024.
//

import Foundation

enum FirebaseQueryConditions : String {
    
    case portfolio
    case watchList
    
    var field : String {
        switch self {
        case .portfolio:
            "coin_amount"
        case .watchList:
            "is_in_watch_list"
        }
    }
    
    var value : Any {
        switch self {
        case .portfolio:
            0
        case .watchList:
            true
        }
    }
    
    
}
