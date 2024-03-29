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
    
    func convertDoubleToStringFromInt () -> String{
        return String(Int(self))
    }
    
    func convertDoubleToString () -> String {
        return String(format: "%.2f", self)
    }
    
    func convertWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.convertDoubleToString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.convertDoubleToString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.convertDoubleToString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.convertDoubleToString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.convertDoubleToString()

        default:
            return "\(sign)\(self)"
        }
    }
    

}

extension Int {
    func convertIntToString () -> String {
        return String(self)
    }
}

extension Date {
    
    init(willFormattedDate : String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: willFormattedDate) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func convertDateToString () -> String {
        return dateFormatter.string(from: self)
    }

}

extension String {
    
    func convertToDouble () -> Double {
        let cleanedInput = self.replacingOccurrences(of: ",", with: ".")
        return Double(cleanedInput) ?? 0
    }
    
}

extension UIApplication {
    
    func endEditing () {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
