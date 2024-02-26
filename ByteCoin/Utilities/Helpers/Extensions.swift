//
//  Extensions.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 23.02.2024.
//

import Foundation
import UIKit

extension Double {
    
    private var currencyFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    private var numberFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func convertCurrency () -> String {
        return currencyFormatter.string(for: self) ?? "0.00"
        
    }
    
    func convertPrecentages () -> String {
        return (numberFormatter.string(for: self) ?? "0.0") + "%" 
    }
    
    func convertNumberToString () -> String {
        return String(format: "%.2f", self)
    }
    
    func convertWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.convertNumberToString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.convertNumberToString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.convertNumberToString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.convertNumberToString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.convertNumberToString()

        default:
            return "\(sign)\(self)"
        }
    }
    

}

extension Int {
    func convertNumberToString () -> String {
        return String(self)
    }
}

extension UIApplication {
    
    func endEditing () {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
