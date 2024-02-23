//
//  Send Again.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 22.02.2024.
//

import SwiftUI

struct RecentTransaction: View {
    
    let user : UserResult
    
    var body: some View {
        VStack(spacing : 10) {
            AsyncImage(url: URL(string: user.picture?.large ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60,height: 60)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .fill(.placeholder)
                    .frame(width: 55,height: 55)
                    
            }
            VStack(spacing : 0) {
                Text(user.name?.first ?? "")
                    .font(.body)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                Text(user.name?.last ?? "")
                    .font(.caption)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
            }

                
        }.frame(width: 100, height: 120)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.regularMaterial)
        )
    }
}

#Preview {
    RecentTransaction(user: UserResult(name: UserName(title: "test", first: "test", last: "test"), picture: UserPicture(large: "", medium: "", thumbnail: "")))
}
