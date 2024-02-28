//
//  CoinExchangeQuantitySection.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 28.02.2024.
//

import SwiftUI

struct CoinExchangeQuantitySection: View {
    
    let sectionName : String
    @Binding var coinAmount : String
    
    var body: some View {
        VStack {
            Text(sectionName)
            Divider()
                .frame(width: 300)
            TextField("Ex : 1.4", text: $coinAmount)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
        }.padding(.vertical, 20)
    }
}

#Preview {
    CoinExchangeQuantitySection(sectionName: "Amount", coinAmount: .constant("11"))
}
