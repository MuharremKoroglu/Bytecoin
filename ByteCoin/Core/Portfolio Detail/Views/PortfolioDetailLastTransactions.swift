//
//  PortfolioViewLastTransactions.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 6.03.2024.
//

import SwiftUI

struct PortfolioDetailLastTransactions: View {
    
    @StateObject var viewModel : PortfolioDetailViewViewModel
    
    private let spacing : CGFloat = 30
     
    private let columns : [GridItem] = [
         GridItem(.flexible()),
         GridItem(.flexible()),
     ]
     
    var body: some View {
        VStack (alignment : .leading) {
            Text("Last Transactions")
                .font(.title)
                .fontWeight(.bold)
            Divider()
            LazyVGrid(columns: columns,
                      alignment: .leading,
                      spacing: spacing,
                      content: {
                ForEach(viewModel.allUsers, id: \.id) { user in
                    RecentTransaction(user: user)
                }
            })
        }.padding()
            .onAppear{
                viewModel.getAllUser()
            }
    }
}


