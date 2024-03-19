//
//  CoinDetailGridSharedView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 18.03.2024.
//

import SwiftUI

struct CoinDetailGridSharedView <Content : View> : View {
        
    let title : String
    
    let content : (() -> Content)
     
    private let spacing : CGFloat = 30
     
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
     
     var body: some View {
         VStack (alignment : .leading) {
             Text(title)
                 .font(.title)
                 .fontWeight(.bold)
             Divider()
             LazyVGrid(columns: columns,
                       alignment: .leading,
                       spacing: spacing,
                       content: {
                 content()
             })
             
         }.padding()
     }
}
