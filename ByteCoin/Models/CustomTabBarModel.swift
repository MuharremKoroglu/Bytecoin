//
//  CustomTabBarModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import Foundation

enum Tabs : String, CaseIterable {
    
    case home = "Home"
    case listOfCoins = "Market"
    case portfolio = "Portfolio"
    case settings = "Settings"
    
    var tagNumber : Int {
        switch self {
        case .home:
            return 1
        case .listOfCoins:
            return 2
        case .portfolio:
            return 3
        case .settings:
            return 4
        }
    }
    
    var iconName : String {
        switch self {
        case .home:
            return "house"
        case .listOfCoins:
            return "list.clipboard"
        case .portfolio:
            return "chart.pie"
        case .settings:
            return "gearshape"
        }
    }

    var fillIconName : String {
        return iconName + ".fill"
    }
    
}
