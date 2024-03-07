//
//  ButtonsModel.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import Foundation
import SwiftUI

enum ButtonsModel : String {
    
    case buy
    case sell
    
    var buttonTitle : String {
        switch self {
        case .buy:
            return "Buy"
        case .sell:
            return "Sell"
        }
    }
    
    var buttonIcon : String {
        switch self {
        case .buy:
            return "arrow.down.backward"
        case .sell:
            return "arrow.up.forward"
        }
    }
    
    var buttonColor : Color {
        switch self {
        case .buy:
            return .green
        case .sell:
            return .red
        }
    }
    
}
