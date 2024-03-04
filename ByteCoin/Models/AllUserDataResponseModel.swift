//
//  UserModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import Foundation

struct AllUserDataResponseModel: Codable, Identifiable {
    var id = UUID()
    let results: [UserResult]?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct UserResult: Codable, Identifiable  {
    var id = UUID()
    let name: UserName?
    let picture: UserPicture?
    
    enum CodingKeys: String, CodingKey {
        case name
        case picture
    }
}

struct UserName: Codable, Identifiable  {
    var id = UUID()
    let title, first, last: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case first
        case last
    }
    
}

struct UserPicture: Codable, Identifiable  {
    var id = UUID()
    let large, medium, thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case large
        case medium
        case thumbnail
    }
}
