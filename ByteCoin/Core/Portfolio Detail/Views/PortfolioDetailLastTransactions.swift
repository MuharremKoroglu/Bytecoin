//
//  PortfolioViewLastTransactions.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 6.03.2024.
//

import SwiftUI

struct PortfolioDetailLastTransactions: View {
    
    @StateObject var viewModel : PortfolioDetailViewViewModel
     
    var body: some View {
        CoinDetailGridSharedView(title: "Last Transactions") {
            Group {
                ForEach(viewModel.allUsers, id: \.id) { user in
                    RecentTransaction(user: user)
                }
            }
        }.onAppear{
            viewModel.getAllUser()
        }
    }
}


