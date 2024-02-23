//
//  UserWelcomeView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct UserWelcome: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading,spacing: 5){
                Text("Welcome,")
                    .font(.headline)
                    .foregroundStyle(.gray)
                    .bold()
                Text("Sam White")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
            }
            Spacer()
            Image(.user)
                .resizable()
                .scaledToFill()
                .frame(width: 55,height: 55)
                .background(.appMain)
                .clipShape(Circle())
                
                
        }
    }
}

#Preview {
    UserWelcome()
}
