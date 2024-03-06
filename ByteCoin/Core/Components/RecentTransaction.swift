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
        HStack(alignment : .center,spacing: 10){
            DownloadImageAsync(url: user.picture?.large ?? "",width: 50,height: 50)
                .frame(width: 60)
            VStack(alignment : .center,spacing: 3) {
                Text(user.name?.first ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(.primary)
                Text(user.name?.last ?? "")
                    .font(.caption)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(.primary)
            } .frame(width: 100)
        }.frame(width: 170, height: 75)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.regularMaterial)
            )
    }
}

#Preview {
    RecentTransaction(user: UserResult(id: UUID(), name: UserName(id: UUID(), title: "Miss", first: "Rensje", last: "Prooijen"), picture: UserPicture(id: UUID(), large: "https://randomuser.me/api/portraits/women/85.jpg", medium: "https://randomuser.me/api/portraits/med/women/85.jpg", thumbnail: "https://randomuser.me/api/portraits/thumb/women/85.jpg")))
}

