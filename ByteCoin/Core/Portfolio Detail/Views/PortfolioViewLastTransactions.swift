//
//  PortfolioViewLastTransactions.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 6.03.2024.
//

import SwiftUI

struct PortfolioViewLastTransactions: View {
    
    @EnvironmentObject private var homeViewModel : HomeViewViewModel
    
    private var spacing : CGFloat = 30
     
    private var columns : [GridItem] = [
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
                ForEach(homeViewModel.allUsers, id: \.id) { user in
                    RecentTransaction(user: user)
                }
            })
        }.padding()
            .onAppear{
                homeViewModel.getAllUser()
            }
    }
}


