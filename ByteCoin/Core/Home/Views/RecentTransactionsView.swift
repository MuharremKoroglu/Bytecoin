//
//  SendAgainView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct RecentTransactionsView: View {
    @StateObject var viewModel : HomeViewViewModel
    
    var body: some View {
        VStack(alignment : .leading,spacing: 10) {
            Text("Recent Transactions")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.allUsers, id: \.id) { user in
                        RecentTransaction(user: user)
                    }
                }
            }
        }.padding(.horizontal, 15)
    }
}
