//
//  CoinExchangePriceSection.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangePriceSection: View {
    let sectionName : String
    let content : String
    
    var body: some View {
        VStack {
            Text(sectionName)
            Divider()
                .frame(width: 150)
            Text(content)
                .font(.title2)
                .fontWeight(.semibold)
        }.padding(.vertical, 20)
    }
}

#Preview {
    CoinExchangePriceSection(sectionName: "Current Price", content: "5")
}
