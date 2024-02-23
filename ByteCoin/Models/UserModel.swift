//
//  UserModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable, Identifiable {
    let id = UUID()
    let results: [UserResult]?
}

// MARK: - Result
struct UserResult: Codable, Identifiable  {
    let id = UUID()
    let name: UserName?
    let picture: UserPicture?
}

// MARK: - Name
struct UserName: Codable, Identifiable  {
    let id = UUID()
    let title, first, last: String?
}

// MARK: - Picture
struct UserPicture: Codable, Identifiable  {
    let id = UUID()
    let large, medium, thumbnail: String?
}
