//
//  GoodByeView.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 9.03.2024.
//

import SwiftUI

struct GoodByeView: View {
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            VStack {
                LottieView(animationName: "bye")
                    .frame(width: size.width , height: size.height * 0.3)
                Text("Goodbye for Now, ByteCoiner")
                    .font(.title2.italic())
                    .fontWeight(.bold)
                Text("Thanks for joining us!")
                    .font(.headline)
                    .padding(.top,5)

            }.frame(width: size.width, height: size.height)
        }
    }
}

#Preview {
    GoodByeView()
}
