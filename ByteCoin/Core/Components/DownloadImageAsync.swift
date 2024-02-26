//
//  DownloadImageAsync.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 26.02.2024.
//

import SwiftUI

struct DownloadImageAsync: View {
    
    let url : String
    let width : CGFloat?
    let height : CGFloat?
    
    init(url: String, width: CGFloat? = 30, height: CGFloat? = 30) {
        self.url = url
        self.width = width
        self.height = height
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
        } placeholder: {
            Circle()
                .fill(.placeholder)
        }.frame(width: width,height: height)
    }
}

#Preview {
    DownloadImageAsync(url: "", width: 30, height: 30)
}
