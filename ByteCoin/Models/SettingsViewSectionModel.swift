//
//  SettingsViewSectionModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 8.03.2024.
//

import SwiftUI

enum SettingsViewSectionModel {
    
    case project
    case firebase
    case coinApi
    case userApi
    case kafein
    
    var sectionTitle : String {
        switch self {
        case .project:
            "ByteCoin"
        case .firebase:
            "Firebase"
        case .coinApi:
            "Coin"
        case .userApi:
            "Random User Generator"
        case .kafein:
            "Kafein Technology Solutions"
        }
    }
    
    var sectionImage : ImageResource {
        switch self {
        case .project:
            return .logo
        case .firebase:
            return .firebaseLogo
        case .coinApi:
            return .apiLogo
        case .userApi:
            return .userApiLogo
        case .kafein:
            return .kafein
        }
    }

    
    var sectionContent : String {
        switch self {
        case .project:
            "This application is a cryptocurrency tracking application. The most profitable and losing coins can be followed in the application, the details and graphics of the coins in the coin market can be accessed, the desired coins can be added to the watch list or a portfolio can be created by buying and selling. This application uses MVVM architecture and Firebase technologies."
        case .firebase:
            "In this application, Anonymous Authentication and Cloud Firestore, which are Firebase products, are used."
        case .coinApi:
            "All cryptocurrency data used in the application is provided by CoinGecko API."
        case .userApi:
            "The users used in the recent transfers section of the application are entirely provided by the Random User Generator API."
        case .kafein:
            "The application was made for Kafein Technology Solutions within the scope of the internship program. Kafein Technology Solutions is a technology company based in the Republic of Turkey that offers technology and software services in many areas."
        }
    }
    
    var linkTitle : String {
        switch self {
        case .project:
            "Check out the Project 🎉"
        case .firebase:
            "Check out the Firebase ⚡️"
        case .coinApi:
            "Check out the CoinGecko 🤑"
        case .userApi:
            "Visit Random User Generator 🏃"
        case .kafein:
            "Visit Kafein Technology Solutions 🏢"
        }
    }
    
    var linkUrl : String {
        switch self {
        case .project:
            "https://github.com/MuharremKoroglu/Bytecoin"
        case .firebase:
            "https://firebase.google.com/"
        case .coinApi:
            "https://www.coingecko.com/"
        case .userApi:
            "https://randomuser.me/"
        case .kafein:
            "https://www.kafein.com.tr/"
        }
    }
    
    
    
    
    
}

