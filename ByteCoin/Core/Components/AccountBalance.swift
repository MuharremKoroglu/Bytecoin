//
//  AccountBalance.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct AccountBalance: View {
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
                    Text("$152,463")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                Spacer()
                HStack{
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12,height: 12)
                        .foregroundStyle(.green)
                    
                    Text("+25%")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                
            }
        }.padding(.horizontal,15)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.appMain)
        )
    }
}

#Preview {
    AccountBalance()
}
