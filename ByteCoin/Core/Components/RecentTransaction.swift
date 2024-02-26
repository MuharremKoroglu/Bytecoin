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
        VStack(alignment : .center,spacing: 10){
            
            DownloadImageAsync(url: user.picture?.large ?? "",width: 40,height: 40)
            
            VStack(alignment : .center,spacing: 3) {
                Text(user.name?.first ?? "")
                    .font(.callout)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(.primary)
                Text(user.name?.last ?? "")
                    .font(.caption)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(.primary)
            }
            
        }.frame(width: 90, height: 110)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.regularMaterial)
            )
    }
}

#Preview {
    RecentTransaction(user: UserResult(name: UserName(title: "test", first: "Antonio", last: "Martinez"), picture: UserPicture(large: "", medium: "", thumbnail: "")))
}
