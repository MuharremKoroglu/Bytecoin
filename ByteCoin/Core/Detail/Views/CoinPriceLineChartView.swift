//
//  CoinPriceLineChartView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 25.02.2024.
//

import SwiftUI

struct CoinPriceLineChartView: View {
    
    let coin : AllCoinsDataResponseModel
        
    var body: some View {
        
        LineChart(coin: coin)
        
    }
}
