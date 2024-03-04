//
//  SingleCoinDataResponseModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import Foundation

struct SingleCoinDataResponseModel : Identifiable, Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let hashingAlgorithm: String?
    let description: Description?
    let links: ImportantLinks?
    
    enum CodingKeys : String, CodingKey {
        case id
        case symbol
        case name
        case hashingAlgorithm = "hashing_algorithm"
        case description
        case links
    }
}

// MARK: - Description
struct Description : Codable {
    let en: String?
}

// MARK: - Links
struct ImportantLinks : Codable {
    let homepage: [String]?
    let whitepaper: String?
}
