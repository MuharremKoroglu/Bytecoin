//
//  CoinDetailItem.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 26.02.2024.
//

import SwiftUI

struct CoinDetailItem: View {
    
    let title : String
    let value : String
    let marketCapChange : Double?
    
    init(title: String, value: String, marketCapChange: Double? = nil) {
        self.title = title
        self.value = value
        self.marketCapChange = marketCapChange
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            if marketCapChange != nil {
                HStack(spacing : 5){
                    Image(systemName: marketCapChange! >= 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10,height: 10)
                        .foregroundStyle(marketCapChange! >= 0 ? .green : .red)
                    
                    Text(marketCapChange!.convertPrecentages())
                        .font(.callout)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .foregroundStyle(marketCapChange! >= 0 ? .green : .red)
                }
            }
        }
    }
    
}
