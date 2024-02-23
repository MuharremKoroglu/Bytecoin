//
//  AllUserDataRequestModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import Foundation

struct AllUserDataRequestModel : Encodable {
    
    let results : Int
    let include : String
    let nationality : String
    let noinfo : String
    
    enum CodingKeys : String, CodingKey {
        case results
        case include = "inc"
        case nationality = "nat"
        case noinfo
    }
    
}
