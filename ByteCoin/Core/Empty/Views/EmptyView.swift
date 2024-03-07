//
//  EmptyView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 7.03.2024.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        GeometryReader{ geometry in
            let size = geometry.size
            VStack(spacing: 15) {
                LottieView(animationName: "portfolio")
                    .frame(width: size.width, height: size.height * 0.4)
                Text("Your portfolio looks empty :(")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Check out the coin market to add a new coin to your portfolio.")
                    .font(.callout)
                    .frame(width: size.width * 0.5)
                    .multilineTextAlignment(.center)

            }.frame(width: size.width, height: size.height)
        }
        
    }
}

#Preview {
    EmptyView()
}
