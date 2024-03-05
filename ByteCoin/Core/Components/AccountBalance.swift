//
//  AccountBalance.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct AccountBalance: View {
    
    let accountBalance : Double
    let accountProfit : Double
    
    var body: some View {
        VStack (alignment : .leading,spacing: 25) {
            VStack (alignment: .leading){
                Text("Wallet")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

            }
            HStack(alignment: .bottom) {
                VStack(alignment: .leading,spacing: 5) {
                    Text("Your Current Balance")
                        .font(.title3)
                        .foregroundStyle(.white)
                    Text(accountBalance.convertCurrency())
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                Spacer()
                HStack{
                    Image(systemName: accountProfit > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12,height: 12)
                        .foregroundStyle(accountProfit > 0 ? .green : .red)
                    
                    Text(accountProfit.convertPrecentages())
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                
            }
        }.padding(.horizontal,15)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(.appMain)
        )
    }
}
